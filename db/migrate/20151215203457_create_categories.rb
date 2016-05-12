class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :enabled 

      t.timestamps null: false
    end
    add_index :categories, :enabled
  end
end
