class EmployeesController < ApplicationController
  def index
    @employees = User.where(role: 'employee')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(current_user) 
    else
      render :new
    end
  end
  
  def destroy
    @employee = User.find_by(id: params[:id])
    @employee.destroy
    redirect_to employee_path 
  end

  def edit
    @employee = User.find_by(id: params[:id])
  end

  def update
    @employee = User.find_by(id: params[:id])
    if @employee.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :role, :phone)
  end
end
