class ChangeFileToFileNameIdentificator < ActiveRecord::Migration
  def change
    remove_index :entities, :file
    remove_column :entities, :file

    add_column :entities, :s, :string
    add_column :entities, :x, :string
    add_column :entities, :l, :string
    add_column :entities, :w, :string
    add_index :entities, [:s, :x, :l, :w]
    add_index :entities, :s
    add_index :entities, :x
    add_index :entities, :l
    add_index :entities, :w
  end
end
