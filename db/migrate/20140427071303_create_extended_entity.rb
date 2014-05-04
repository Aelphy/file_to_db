class CreateExtendedEntity < ActiveRecord::Migration
  def change
    create_table :extended_entities do |t|
      (1..32).each do |column_nomber|
        t.float "column_#{column_nomber}".to_sym
      end

      t.string :s
      t.string :x
      t.string :l
      t.string :w
      t.timestamps
    end
  end
end
