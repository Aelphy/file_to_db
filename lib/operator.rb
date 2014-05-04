module Operator
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    DICTIONARY = {a: 0,
                  b: 12.5,
                  c: 25,
                  d: 37.5,
                  e: 50,
                  f: 62.5,
                  g: 75,
                  h: 87.5,
                  i: 100,
                  j: 112.5,
                  k: 125,
                  l: 137.5,
                  m: 150,
                  n: 162.5,
                  o: 175,
                  p: 187.5,
                  q: 200}

    # Public: compute scale of every field in a given file
    #
    # file_hash - Hash, содержит в себе идентификаторы файла
    #
    # Returns Hash
    def file_scale(file_hash)
      scale(where(file_hash))
    end

    # Public: compute scale of given file
    #
    # file_hash - Hash, содержит в себе идентификаторы файла
    #
    # Returns Hash
    def total_file_scale(file_hash)
      values = []

      where(file_hash).each do |entity|
        self::COLUMNS.each do |column|
          values << entity[column]
        end
      end

      return unless values.present?

      values.max - values.min
    end

    # Public: compute scale of every field
    #
    # Returns Hash
    def total_scale
      scale(self)
    end

    def build_image_by_rows(name)
      entity_hash = build_entities_hash(name)

      x = (1..32).map { |i| i }
      y = file_scale(entity_hash).values
      file_name = "#{entity_hash.values[0]}#{entity_hash.values[1]}#{entity_hash.values[2]}#{entity_hash.values[3]}"


      build_image(x, y, "#{file_name}_by_columns.png", entity_hash)
    end

    # rewrite
    def build_image_by_files(hash)
      raise 'надо 3 параметра' if hash.size != 3

      param = ([:s, :x, :l,:w] - hash.keys).first

      x = []
      y = []
      file_name = "total_#{param}"
      hash.each { |k, v| file_name += "_#{k}_#{v}" }

      Identificator.where('LENGTH(name) = ?', self::FILENAME_SIZE).pluck(:name).each do |name|
        entity_hash = build_entities_hash(name)
        need_to_continue = true
        hash.each { |k, v| need_to_continue = false if entity_hash[k] != v }

        next if need_to_continue || total_file_scale(entity_hash).nil?

        x << if param == :x && entity_hash[param].size == 1
               DICTIONARY[entity_hash[param].to_sym]
             else
               entity_hash[param].to_i
             end

        y << total_file_scale(entity_hash)
      end

      build_image(x, y, file_name, nil, true)
    end

    def build_entities_hash(name)
      if name.size == 4
        {s: name[0], x: name[1], l: name[2], w: name[3]}
      else
        {s: name[0], x: name[1..4], l: name[5], w: name[6]}
      end
    end

    def build_image(x, y, file_name, entity_hash, by_file = false)
      Gnuplot.open do |gp|
        Gnuplot::Plot.new(gp) do |plot|
          unless by_file
            return unless self.file_scale(entity_hash)
          end

          plot.xrange "[#{x.min}:#{x.max}]"
          plot.ylabel 'y'
          plot.xlabel 'x'
          plot.terminal 'png'
          plot.output File.join('output',file_name)

          plot.data = [ Gnuplot::DataSet.new([x, y]) { |ds| ds.with = 'linespoints' } ]
        end
      end
    end

    def imaginate
      # Identificator.where('LENGTH(name) = ?', self::FILENAME_SIZE).pluck(:name).each do |name|
      #   build_image_by_rows name
      # end

      build_image_by_files(s: '3', l: '6', w: '3')
    end

    private

    # Internal: scale of given objects
    #
    # Returns Hash
    def scale(entities)

      return if entities.blank?

      self::COLUMNS.reduce({}) do |a, e|
        a[e] = entities.maximum(e) - entities.minimum(e)
        a
      end
    end
  end

  module InstanceMethods
    # Public: compute line nomber from file
    #
    # Return Integer
    def line_nomber
      return @line_nomber if @line_nomber.present?
      zero_line = self.class.where(s: s, x: x, l: l, w: w).order(:id).first.id

      @line_nomber = id - zero_line
    end
  end
end
