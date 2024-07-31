class InterviewsController < ApplicationController
  include CandidatesHelper
  before_action :find_user
  before_action :fetch_candidates_and_employees, only: [:new, :edit]

  def index
    if @user == nil
      redirect_to user_interviews_path(current_user,status: params[:status])
    else
      if params[:status]
        @interviews = @user.interviews.where(status: params[:status])
      else
        @interviews = @user.interviews.all
      end
    end
  end

  def new
    if @user == nil
      redirect_to new_user_interview_path(current_user)
    else
      @interview = @user.interviews.new
    end
  end

  def create
    existing_interview = Interview.find_by(candidate_id: interview_params[:candidate_id])
      if !existing_interview
        @interview = @user.interviews.build(interview_params)
        @interview.status = "Pending"
        if @interview.save!
          flash[:notice] = "Interview successfully created."
          redirect_to user_path(@user)
        else
          flash[:notice] = "There was a problem interview the employee."
          fetch_candidates_and_employees
          render :new
        end
      end
  end

  def edit
    @interview = @user.interviews.find_by(id: params[:id])
    fetch_candidates_and_employees
  end

  def update
    @interview = @user.interviews.find_by(id: params[:id])

    if current_user.role == "employee"
      next_round = next_interview_round(@interview.round)
      @interview.update(round: next_round)
    else
      @interview.feedback =""
      @interview.status =""
    end

    if @interview.update(interview_params)
      if current_user.role == "employee"
        redirect_to show_interview_employee_path(current_user[:id])
      else
        redirect_to user_interviews_path(@user)
      end
    else
      flash[:notice] = "There was a problem updating the employee."
      render :edit
    end
  end

  def destroy
    @interview = @user.interviews.find_by(id: params[:id])
    if @interview == nil 
      redirect_to user_interviews_path(current_user,status: params[:status])
    else
      @interview.destroy
      flash[:notice] = "Interview successfully deleted."
      redirect_to user_interviews_path(@user)
    end
  end

  private

  def find_user
    @user ||= User.find_by(id: params[:user_id])
  end

  def fetch_candidates_and_employees
    interviewed_candidate_ids = Interview.pluck(:candidate_id)
    @candidates = Candidate.where.not(id: interviewed_candidate_ids)
    @employees = User.where(role: 'employee')
  end

  def next_interview_round(current_round)
    return Interview.rounds.keys.first if current_round.nil?
    next_round_index = Interview.rounds.keys.index(current_round.to_s) + 1
    Interview.rounds.keys[next_round_index]
  end

  def interview_params
    params.require(:interview).permit(:status, :feedback, :round, :interview_time, :candidate_id, :employee_id)
  end
end
