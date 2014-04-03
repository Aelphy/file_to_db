class Entity < ActiveRecord::Base
  COLUMNS = (1..32).map { |column_nomber| "column_#{column_nomber}".to_sym }

  COLUMNS.each { |column| validates column, presence: true }

  validates :s, presence: true
  validates :x, presence: true
  validates :l, presence: true
  validates :w, presence: true

  # Public: compute scale of every field in a given file
  #
  # file_hash - Hash, содержит в себе идентификаторы файла
  #
  # Returns Hash
  def self.file_scale(file_hash)
    scale(Entity.where(file_hash))
  end

  # Public: compute scale of given file
  #
  # file_hash - Hash, содержит в себе идентификаторы файла
  #
  # Returns Hash
  def self.total_file_scale(file_hash)
    values = []

    Entity.where(file_hash).each do |entity|
      COLUMNS.each do |column|
        values << entity[column]
      end
    end

    values.max - values.min
  end

  # Public: compute scale of every field
  #
  # Returns Hash
  def self.total_scale
    scale(Entity)
  end

  # Public: compute line nomber from file
  #
  # Return Integer
  def line_nomber
    return @line_nomber if @line_nomber.present?
    zero_line = Entity.where(s: s, x: x, l: l, w: w).order(:id).first.id

    @line_nomber = id - zero_line
  end

  private

  # Internal: scale of given objects
  #
  # Returns Hash
  def self.scale(entities)

    return if entities.blank?

    COLUMNS.reduce({}) do |a, e|
      a[e] = entities.maximum(e) - entities.minimum(e)
      a
    end
  end
end
