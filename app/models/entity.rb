class Entity < ActiveRecord::Base
  def self.start
    dir_name = File.join(Rails.root, 'public', 'files')

    Dir.foreach(dir_name) do |file_name|
      file_path = File.join(dir_name)

      CSV.foreach(file_path) do |row|
        create([row, file_name])
      end
    end
  end
end
