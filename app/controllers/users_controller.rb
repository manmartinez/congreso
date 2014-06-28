# encoding UTF-8
class UsersController < ApplicationController
  def login
    if session[:admin_id]
      redirect_to admin_root_url
    end
  end

  def logout
    reset_session
    redirect_to root_url
  end

  def authenticate
    @admin = Admin.authenticate(params[:email], params[:password])
    if @admin
      session[:admin_id] = @admin.id
      redirect_to admin_root_url
    else
      flash[:alert] = 'Usuario / Contraseña incorrectos'
      redirect_to login_url
    end
  end
end
