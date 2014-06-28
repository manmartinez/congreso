class Api::SpeakersController < Api::SharedController
  def index
    @speakers = Speaker.includes(:activities).order(:name)
    render json: @speakers.as_json(
      include: {
        activities: { 
          only: [:id, :name, :starts_at, :ends_at ], 
          methods: [:type_name],
          include: { room: { only: [:name] } }
        }
      }
    )
  end

  def show
    @speaker = Speaker.find(params[:id])
    render json: @speaker.as_json(
      include: {
        activities: { 
          only: [:id, :name, :starts_at, :ends_at ], 
          methods: [:type_name],
          include: { room: { only: [:name] } }
        }        
      }
    )
  end
end
