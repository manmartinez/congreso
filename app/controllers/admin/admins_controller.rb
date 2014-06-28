class Admin::AdminsController < Admin::SharedController
  params_for :admin, :name, :email, :password, :password_confirmation

  def index    
    @admins = Admin.page(params[:page])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_admins_url, notice: 'El administrador se ha creado'
    else
      render action: 'new'
    end
  end

  def edit
    @admin = Admin.find(params[:id])     
  end

  def update
    @admin = Admin.find(params[:id])

    if @admin.update_attributes(admin_params)
      redirect_to admin_admins_url, notice: 'El administrador se ha actualizado'
    else
      render action: 'edit'
    end    
  end

  def destroy
    @admin = Admin.find(params[:id])

    if @admin.destroy
      redirect_to admin_admins_url, notice: 'El administrador se ha eliminado'
    else
      redirect_to admin_admins_url, alert: 'Algo salió mal'
    end
  end
end
