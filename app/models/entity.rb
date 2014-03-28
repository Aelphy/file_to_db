require 'csv'

class Entity < ActiveRecord::Base
  (1..32).each do |column_nomber|
    validates "column_#{column_nomber}".to_sym, presence: true
  end

  validates :s, presence: true
  validates :x, presence: true
  validates :l, presence: true
  validates :w, presence: true
end
