class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      (1..32).each do |column_nomber|
        t.float "column_#{column_nomber}".to_sym
      end

      t.string :file
      t.timestamps
    end

    add_index :entities, :file
  end
end
