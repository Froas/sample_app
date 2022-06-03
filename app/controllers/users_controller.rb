class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    
    if @user.save
      flash[:success] = "Wellcome to the Gym, #{@user.name}"
      redirect_to @user
      log_in @user
    else
      render 'new'
    end
  end
  #к ней так обращаются тоже
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    
  end

end
