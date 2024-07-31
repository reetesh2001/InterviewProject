class CandidatesController < ApplicationController
  before_action :find_user

  def index
    if @user == nil
      redirect_to user_candidates_path(current_user)
    else
      @candidates = @user.candidates.all
    end
  end

  def new
    if @user == nil
      redirect_to new_user_candidate_path(current_user)
    else
      @candidate = @user.candidates.build
    end
  end

  def create
    @candidate = @user.candidates.build(candidate_params)
    if @user
      if @candidate.save!
        flash[:notice] = "Candidate successfully created."
        redirect_to user_path(@user)
      else
        flash[:notice] = "There was a problem creating the candidate."
        render :new
      end
    else
      flash[:notice] = "Invalid user. Candidate could not be created."
      render :new
    end
  end

  def edit
    @candidate = @user.candidates.find_by(id: params[:id])
  end

  def update
    @candidate = @user.candidates.find_by(id: params[:id])
    if @candidate.update(candidate_params)
      flash[:notice] = "Successfully Updated"
      redirect_to user_candidates_path(@user)
    else
      flash[:notice] = "There was a problem in updating"
      render :edit
    end
  end

  def destroy
    @candidate = @user.candidates.find_by(id: params[:id])
    if @candidate
      @candidate.destroy
      flash[:notice] = "Candidate successfully deleted."
      redirect_to user_candidates_path(@user)
    else
      redirect_to user_candidates_path(current_user)
    end
  end

  private

  def find_user
    @user ||= User.find_by(id: params[:user_id])
  end

  def candidate_params
    params.require(:candidate).permit(:name, :email, :phone, :role, :qualification, :college, :experience, :company)
  end
end
