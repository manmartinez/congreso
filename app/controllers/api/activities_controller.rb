class Api::ActivitiesController < Api::SharedController
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
