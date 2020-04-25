class AddSkillNameToSkills < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :skill_name, :string
  end
end
