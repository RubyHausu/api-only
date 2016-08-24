class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:update]

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def index
    render json: User.all
  end

  def update
    @user = User.find(params[:id])
    #return api_error(status: 403) if !UserPolicy.new(current_user, @user).update?
    #或可使用此方法,无需捕获异常
    authorize @user, :update?
    @user.update_attributes(update_params)
    render json: @user
  end

   private
    def update_params
      params.require(:user).permit(:name)
    end
end
