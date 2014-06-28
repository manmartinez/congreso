# encoding: UTF-8
class Admin::RoomsController < Admin::SharedController

  params_for :room, :name

  def index    
    @rooms = Room.page(params[:page])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to admin_rooms_url, notice: 'El salón se ha creado'
    else
      render action: 'new'
    end
  end

  def edit
    @room = Room.find(params[:id])     
  end

  def update
    @room = Room.find(params[:id])

    if @room.update_attributes(room_params)
      redirect_to admin_rooms_url, notice: 'El salón se ha actualizado'
    else
      render action: 'edit'
    end    
  end

  def destroy
    @room = Room.find(params[:id])

    if @room.destroy
      redirect_to admin_rooms_url, notice: 'El salón se ha eliminado'
    else
      redirect_to admin_rooms_url, alert: 'Algo salió mal'
    end
  end
end
