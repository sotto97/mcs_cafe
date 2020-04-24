class RemoveNameFromSkills < ActiveRecord::Migration[5.2]
  def change
    remove_column :skills, :name, :string
  end
end
