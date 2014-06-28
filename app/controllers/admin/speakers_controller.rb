class Admin::SpeakersController < Admin::SharedController
  params_for :speaker, :salutation, :company, :name, :photo, :bio

  def index    
    @speakers = Speaker.page(params[:page])
  end

  def new
    @speaker = Speaker.new
  end

  def create
    @speaker = Speaker.new(speaker_params)

    if @speaker.save
      redirect_to admin_speakers_url, notice: 'El conferencista se ha creado'
    else
      render action: 'new'
    end
  end

  def edit
    @speaker = Speaker.find(params[:id])     
  end

  def update
    @speaker = Speaker.find(params[:id])

    if @speaker.update_attributes(speaker_params)
      redirect_to admin_speakers_url, notice: 'El conferencista se ha actualizado'
    else
      render action: 'edit'
    end    
  end

  def destroy
    @speaker = Speaker.find(params[:id])

    if @speaker.destroy
      redirect_to admin_speakers_url, notice: 'El conferencista se ha eliminado'
    else
      redirect_to admin_speakers_url, alert: 'Algo salió mal'
    end
  end
end
