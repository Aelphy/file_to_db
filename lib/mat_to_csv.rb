class MatToCSV
  def self.run(string)
    # itterate all files
    Dir.glob(File.join('.', 'public', 'files', string, '**', '*QWAD.mat')).sort.each do |file_path|
      new_path = file_path.sub(File.basename(file_path), 'QWAD.mat')
      File.rename(file_path, new_path)
      # convert mat files to csv
      system("./bin/mat_to_csv.py #{new_path}")
    end
  end
end