require 'csv'
class CSVToDB
  def self.run
    Dir.glob(File.join('.', 'public', 'files', '**', '*QWAD.mat')).sort.each do |file_path|
      name = File.basename(File.dirname(file_path))
      Identificator.create(name: name) unless Identificator.where(name: name).present?
    end

    Identificator.pluck(:name).each do |dir_name|
      file_path = Dir.glob("./public/files/**/#{dir_name}/*QWAD.csv").first

      if dir_name.size == 4
        s = dir_name[0]
        x = dir_name[1]
        l = dir_name[2]
        w = dir_name[3]

        CSV.open(file_path, row_sep: :auto, col_sep: ';') do |csv|
          csv.each do |row|
            data = row + [s, x, l, w]
            columns = Entity::COLUMNS + [:s, :x, :l, :w]

            h = {}

            columns.each_with_index do |value, index|
              h[value] = data[index]
            end

            Entity.create(h) unless Entity.where(h).present?
          end
        end
      else
        s = dir_name[0]
        x = dir_name[1..4]
        l = dir_name[5]
        w = dir_name[6]

        CSV.open(file_path, row_sep: :auto, col_sep: ';') do |csv|
          csv.each do |row|
            data = row + [s, x, l, w]
            columns = ExtendedEntity::COLUMNS + [:s, :x, :l, :w]

            h = {}

            columns.each_with_index do |value, index|
              h[value] = data[index]
            end

            ExtendedEntity.create(h) unless ExtendedEntity.where(h).present?
          end
        end
      end
    end
  end
end
