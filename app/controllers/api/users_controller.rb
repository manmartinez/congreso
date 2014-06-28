class Api::UsersController < Api::SharedController

  params_for :user, :email, :full_name

  # POST /api/users.json
  def create
    @user = User.create_with(user_params).find_or_create_by(email: params[:user][:email])

    if @user.valid?
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
end
