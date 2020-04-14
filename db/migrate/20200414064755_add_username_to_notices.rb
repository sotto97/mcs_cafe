class AddUsernameToNotices < ActiveRecord::Migration[5.2]
  def change
    add_column :notices, :username, :string
  end
end
