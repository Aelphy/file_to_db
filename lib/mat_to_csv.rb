class MatToCSV
  def self.run
    # itterate all files
    Dir.glob('./public/files/**/*QWAD.mat').each do |file_path|
      # convert mat files to csv
      system("./bin/mat_to_csv.py #{file_path}")
    end
  end
end