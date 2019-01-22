class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  def login
    authenticate params[:username], params[:password]
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def register
    @user = User.create(user_params)
   if @user.save
    response = { message: 'User created successfully', status: :created }
    render json: response
   else
    render json: @user.errors, status: :bad
   end 
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def test
    render json: {
          message: 'You have passed authentication and authorization test'
        }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :email, :password)
    end

    def authenticate(username, password)
      command = AuthenticateUser.call(username, password)
      token = command.result
      decoded_token = JsonWebToken.decode(token)
      expiration_time = decoded_token[:exp]
      two_hours_from_now = expiration_time + 2 * 3600
      if command.success?
        render json: {
          access_token: token,
          message: 'Login Successful'
        }
      # Handling user token which is 2 hours old  
      elsif Time.now.to_i < two_hours_from_now          
        new_command = AuthenticateUser.call(username, password)
        render json: {
          access_token: new_command.result,
          message: 'Login Successful'
        }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
   end

   def exchange_2_hours_old_token_with_fresh_token()

   end
end
