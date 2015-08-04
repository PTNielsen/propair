class FeedbacksController < ApplicationController
  
  before_action do
    request.format = :json
  end

  # Nice to have.  Incomplete.

  def new
    @feedback = Feedback.new
    authorize! :create, feedback
  end

  def create
    project     = Project.find params[:id]
    partnership = Partnership.find_by_project_id(project.id)
    feedback    = current_user.feedbacks.create!(create_feedback_params)
    authorize! :create, feedback

    if feedback.save
      flash[:notice] = "Feedback was successfully submitted"
    else
      flash[:notice] = "An error occured creating your project."
    end
    head :ok      
  end

  def edit
    feedback = Feedback.new
    authorize! :update, feedback

    head :ok
  end

  def update
  end

  def destroy
    feedback = Feedback.find params[:id]
    authorize! :destroy, project

    feedback.delete
    head :ok
  end

private

  def create_feedback_params
    params.require(:feedback).permit(:body, :rating)
  end

  def edit_feedback_params
    params.require(:feedback).permit(:body, :rating)
  end

end