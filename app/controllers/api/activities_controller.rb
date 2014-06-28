class Api::ActivitiesController < ApplicationController
  def index
    @activities = Activity.search(params).includes(:speaker, :room).order(:starts_at)
    render json: @activities.as_json(
      methods: [ :type_name ],
      include: {
        speaker: { only: [:id, :salutation, :name, :photo] },
        room: { only: [:id, :name] }
      }
    )
  end
end
