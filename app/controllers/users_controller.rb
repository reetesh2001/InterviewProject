class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
    if @user.role == "employee"
      @employee_select_count=Interview.where(employee_id:@user.id,status: 'Selected').count
      @employee_not_select_count=Interview.where(employee_id:@user.id,status: 'Not selected').count
      @employee_pending_count=Interview.where(employee_id:@user.id,status: 'Pending').count
    else
      @selected_count = Interview.where(status: 'Selected').count
      @not_selected_count = Interview.where(status: 'Not selected').count
      @pending_count = Interview.where(status: 'Pending').count
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :name, :role, :phone)
  end
end
