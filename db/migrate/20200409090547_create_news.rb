class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.integer :admin_id
      t.string :admin_id
      t.text :body
      t.timestamps
    end
  end
end
