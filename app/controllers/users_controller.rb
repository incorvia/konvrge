class UsersController < ApplicationController

  def edit
    @new_event = Event.new
    @user = current_user
  end

  def update
    current_user.update_attributes!(params[:user])
    redirect_to edit_user_path(current_user)
  end

  def delete
    super
  end
end
