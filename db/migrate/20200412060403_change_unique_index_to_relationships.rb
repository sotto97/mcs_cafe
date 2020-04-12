class ChangeUniqueIndexToRelationships < ActiveRecord::Migration[5.2]
  def up
  	add_index :relationships, [:follower_id, :following_id], unique: true
  end

  def down
  	remove_index :relationships, [:follower_id, :following_id], unique: true
  end
end
