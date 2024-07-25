class CandidatesController < ApplicationController
  before_action :find_user
  before_action :find_candidate

  def index
    @candidates = @user.candidates.all
  end
  
  def new
    @candidate = @user.candidates.build
  end

  def create
    @candidate = @user.candidates.build(candidate_params)
    if @candidate.save!
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to user_candidates_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    redirect_to user_candidates_path(@user)
  end

  private

  def find_user
    @user ||= User.find_by(id: params[:user_id])
  end

  def find_candidate
    @candidate = @user.candidates.find_by(id: params[:id])
  end
    
  def candidate_params
    params.require(:candidate).permit(:name, :email, :phone, :role, :qualification, :college, :experience, :company)
  end
end
