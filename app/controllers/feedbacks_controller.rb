class FeedbacksController < ApplicationController
  
  before_action do
    request.format = :json
  end

  def new
    @feedback = Feedback.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @feedback = Feedback.find params[:id]
    @feedback.delete
  end

private

  def create_feedback_params
  end

end