class InterviewsController < ApplicationController
  before_action :find_user

  def index
    @interviews = @user.interviews.all
  end

  def new
    @interview = @user.interviews.build
  end
  
  
  def create
    @interview = @user.interviews.build(interview_params)
    if @interview.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @interview = @user.interviews.find(params[:id])
  end

  def update
    @interview = @user.interviews.find(params[:id])
    if @interview.update(interview_params)
      redirect_to user_interviews_path(@user)
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

  def interview_params
    params.require(:interview).permit(:status, :feedback, :round, :interview_time, :candidate_id, :hr_id)
  end
end
