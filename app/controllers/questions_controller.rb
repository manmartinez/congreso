class QuestionsController < ApplicationController

  def index
    @activities = Activity.order(:name)    
  end
end
