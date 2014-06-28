class Api::SharedController < ApplicationController
  respond_to :json
  before_filter :require_api_key
  skip_before_filter :verify_authenticity_token

  protected
    def require_api_key
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        ApiKey.find_by(key: token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render_error(:unauthorized, 'Bad Credentials')
    end

    def render_error(status, message)
      render json: { error: {message: message}}, status: status
    end
end