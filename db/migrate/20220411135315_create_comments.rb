class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :customer_id
      t.integer :post_id
      t.text :body, null: false
      t.datetime :date, null: false
      
      t.timestamps
    end
  end
end
