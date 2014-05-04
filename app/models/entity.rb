class Entity < ActiveRecord::Base
  include Operator

  COLUMNS = (1..32).map { |column_nomber| "column_#{column_nomber}".to_sym }
  FILENAME_SIZE = 4

  COLUMNS.each { |column| validates column, presence: true }

  validates :s, presence: true
  validates :x, presence: true
  validates :l, presence: true
  validates :w, presence: true
end
