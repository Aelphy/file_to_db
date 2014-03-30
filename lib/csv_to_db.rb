require 'csv'
class CSVToDB
  def self.run
    # itterate all files
    Dir.glob('./public/files/**/*QWAD.csv').each do |file_path|
      dir_name = file_path.scan(%r{/..../}).first.gsub('/', '')

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

          Entity.create(h)
        end
      end
    end
  end
end
