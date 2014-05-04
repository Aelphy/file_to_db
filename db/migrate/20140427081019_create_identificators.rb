class CreateIdentificators < ActiveRecord::Migration
  def change
    create_table :identificators do |t|
      t.string :name
    end
  end
end
