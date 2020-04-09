class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
    	t.string :email
    	t.string :title
    	t.text :body
      t.boolean :is_deleted, null: false, default: false
      t.timestamps
    end
  end
end
