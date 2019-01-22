class GroupsController < ApplicationController
  # User can perform the following functions only if User.token_validity_end_by > Time.now

  # Initially create a Group called 'Admin' from console
  def create
  	if @current_user.group.name == "Admin"
	    @group = Group.new(group_params)
	    if @group.save
	      render json: { root_path, status: :created, location: @group }
	    end
	end    
  end

  def assign_users_to_group(*userids,groupid)
  	if @current_user.group.name == "Admin"	
	    @userids = userids
	    @group = Group.find(groupid)
	    @userids.each do |userid|
	      @user = User.find(userid)
	      @user.groups << @group
	    end
	end    
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
