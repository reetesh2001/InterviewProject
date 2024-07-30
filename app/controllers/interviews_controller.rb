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
    existing_interview = Interview.find_by(candidate_id: interview_params[:candidate_id])
    if !existing_interview || existing_interview.status.present?
      @interview = @user.interviews.build(interview_params)
      if @interview.save!
        SendInterviewEmailsJob.perform_later(@interview)
        redirect_to user_path(@user)
      else
        render :new
      end
    end
  end

  def edit
    @interview = @user.interviews.find_by(id: params[:id])
  end

  def update
    @interview = @user.interviews.find_by(id: params[:id])
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
    @interview = @user.interviews.find_by(id: params[:id])
    @interview.destroy
    redirect_to user_interviews_path(@user)
  end

  private

  def find_user
    @user ||= User.find_by(id: params[:user_id])
  end

  def fetch_candidates_and_employees
    candidates_empty_status = Interview.where(status: nil).pluck(:candidate_id)
    @candidates = Candidate.where.not(id: candidates_empty_status )
    @employees = User.where(role: 'employee')
  end

  def interview_params
    params.require(:interview).permit(:status, :feedback, :round, :interview_time, :candidate_id, :employee_id)
  end
end
