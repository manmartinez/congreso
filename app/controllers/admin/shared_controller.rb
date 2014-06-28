class Admin::SharedController < ApplicationController
  layout 'backend'
  before_filter :require_admin_session
  
  protected
    def get_current_user
      @current_user = Admin.find_by(id: session[:admin_id])  
    end

    def require_admin_session
      get_current_user
      unless @current_user
        flash[:warning] = "Por favor inicia sesi&oacute;n"
        redirect_to login_url 
      end
    end
end
