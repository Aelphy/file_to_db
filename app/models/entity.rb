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
    result = {}

    entities = Entity.where(file_hash)

    COLUMNS.each do |column|
      max = entities.maximum(column)
      min = entities.minimum(column)
      result[column] = max - min
    end

    result
  end

  # Public: compute scale of every field
  #
  # Returns Hash
  def self.total_scale
    result = {}

    COLUMNS.each do |column|
      max = Entity.maximum(column)
      min = Entity.minimum(column)
      result[column] = max - min
    end

    result
  end

  # Public: compute line nomber from file
  #
  # Return Integer
  def line_nomber
    return @line_nomber if @line_nomber.present?
    zero_line = Entity.where(s: s, x: x, l: l, w: w).order(:id).first.id

    @line_nomber = id - zero_line
  end
end
