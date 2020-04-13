class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.integer :user_id
      t.text :body
      t.timestamps
    end
  end
end
