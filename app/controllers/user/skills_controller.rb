class User::SkillsController < ApplicationController
  before_action :authenticate_user!
	def create
		@skill = Skill.new(skill_params)
  	@skill.user_id = current_user.id
		@skill.save
		@user = current_user
	end

  def destroy
		@skills = Skill.all
    @skill = Skill.find(params[:id])
    @skill.destroy
  end

	private
	def skill_params
    params.permit(:skill_name, :user_id)
	end
end
