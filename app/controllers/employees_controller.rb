class EmployeesController < ApplicationController
  before_action :find_employee

  def index
    @employees = User.where(role: 'employee')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to user_path(current_user) 
    else
      render :new
    end
  end

  def destroy
    @employee.destroy
    redirect_to employee_path 
  end

  def update
    if @employee.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def find_employee
    @employee = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :role, :phone)
  end
end
