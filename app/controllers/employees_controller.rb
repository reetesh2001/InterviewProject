class EmployeesController < ApplicationController
  before_action :find_employee

  def index
    @employees = Employee.where(role: 'employee')
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(user_params)
    @employee.role = "employee"
    if @employee.save!
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
    @employee ||= Employee.find_by(id: params[:id])
  end

  def user_params
    params.require(:employee).permit(:email, :password, :password_confirmation, :name, :phone)
  end
end
