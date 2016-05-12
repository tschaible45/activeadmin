class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.string :phase
      t.integer :category_id
      t.integer :priority
      t.integer :effort
      t.string :status
      t.date :date_opened
      t.integer :user_id
      t.date :commit_date
      t.integer :assigned_to
      t.integer :related_kb
      t.integer :customer_id
      t.text :comments
      t.datetime :closed_date

      t.timestamps null: false
    end
     add_index :requests, :category_id
     add_index :requests, :user_id
     add_index :requests, :assigned_to
     add_index :requests, :customer_id
  end
end
