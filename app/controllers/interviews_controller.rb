class InterviewsController < ApplicationController
  include CandidatesHelper
  before_action :find_user
  before_action :fetch_candidates_and_employees, only: [:new, :edit]

  def index
    @interviews = @user.interviews.all
  end
 

  def new
    @interview = @user.interviews.new
  end
  
  def create
    @interview = @user.interviews.build(interview_params)
    if @interview.save
      redirect_to user_path(@user)
    else
      fetch_candidates_and_employees
      render :new
    end
  end

  def edit
    @interview = @user.interviews.find(params[:id])
  end

  def update
    @interview = @user.interviews.find(params[:id])
    if @interview.update(interview_params)
      if current_user.role == "employee"
        redirect_to show_interview_employee_path(current_user[:id])
      else
        redirect_to user_interviews_path(@user)
      end
    else
      render :edit
    end
  end

  def destroy
    @interview = @user.interviews.find(params[:id])
    @interview.destroy
    redirect_to user_interviews_path(@user)
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
  end

  def fetch_candidates_and_employees
    @candidates = Candidate.all
    @employees = User.where(role: 'employee')
  end

  def interview_params
    params.require(:interview).permit(:status, :feedback, :round, :interview_time, :candidate_id, :employee_id)
  end
end