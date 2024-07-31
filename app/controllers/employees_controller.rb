class EmployeesController < ApplicationController
  before_action :find_employee

  def index
    @employees = User.where(role: 'employee')
  end

  def show_interview
    @employee = User.find_by(id: params[:id])
    if params[:status]
      @interviews = Interview.where(status: params[:status], employee_id: @employee.id)
    else
      @interviews = Interview.where(employee_id: @employee.id)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      flash[:notice] = "Employee successfully created."
      redirect_to user_path(current_user) 
    else
      flash[:notice] = "There was a problem creating the employee."
      render :new
    end
  end

  def destroy
    @employee.destroy
    flash[:notice] = "Employee successfully deleted."
    redirect_to employee_path 
  end

  def update
    if @employee.update(user_params)
      flash[:notice] = "Successfully Updated"
      redirect_to root_path
    else
      flash[:notice] = "There was a problem updating the employee."
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
