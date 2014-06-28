class Admin::ActivitiesController < Admin::SharedController

  before_filter :get_select_collections, only: [:edit, :new]
  params_for :activity, :name, :activity_type, :description, :starts_at, :ends_at, :room_id, :speaker_id

  def index    
    @activities = Activity.includes(:speaker, :room).page(params[:page])
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      redirect_to admin_activities_url, notice: 'La actividad se ha creado'
    else
      get_select_collections
      render action: 'new'
    end
  end

  def edit
    @activity = Activity.find(params[:id])     
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update_attributes(activity_params)
      redirect_to admin_activities_url, notice: 'La actividad se ha actualizado'
    else
      get_select_collections
      render action: 'edit'
    end    
  end

  def destroy
    @activity = Activity.find(params[:id])

    if @activity.destroy
      redirect_to admin_activities_url, notice: 'La actividad se ha eliminado'
    else
      redirect_to admin_activities_url, alert: 'Algo salió mal'
    end
  end

  protected
    def get_select_collections
      @speakers = Speaker.order(:name)
      @rooms = Room.order(:name)
    end
end
