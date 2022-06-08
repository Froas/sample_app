class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  #before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  def show
    @user = User.find(params[:id])
  end
  

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to index_path
  end

  def admin_set
    
    @user = User.find(params[:id])
    @user.update_attribute(:admin,    true)
    flash[:success] = "#{@user.admin}"
    redirect_to @user
  end 
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      
    else
      render 'new'
    end
  end

  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
  else
    render "edit"
  end
  
  end

  def logged_in_user 
    unless logged_in?
      flash[:danger] = "Please Log in"
      redirect_to login_url
      store_location
    end
  end

  #к ней так обращаются тоже
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def edit 
    @user = User.find(params[:id])
  end

  def correct_user
   @user = User.find(params[:id])
   redirect_to(root_url) unless current_user?(@user)
  end

end
