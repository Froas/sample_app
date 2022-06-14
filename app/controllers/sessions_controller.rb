class SessionsController < ApplicationController



  def new
  end

  def resend_activation
    @user = User.find_by_email(params[:sessions][:email]) 
    @user.create_activation_digest
    if !@user.activated?
      @user.send_activation_email
      flash[:success] = "Activation email resent!"
      redirect_to root_url
    else
      flash.now[:danger] = 'Email is not asociated with any account, please sign up first.'
      redirect_to root_url
    end
  end



  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        redirect_to user
        params[:session][:remember_me] == '1' ? remember(user) : user
      else
        message = "Account not activated. "
        message += "Click #{view_context.link_to " here ", resend_path} for resend activation email"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Your email or password is incorrect "
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end 
#я тоже, надо по книге смотреть или гуглить и по примерам, сейчас подойду, хард глина ооп да
#а вот нашел определение @ - это instance variables of class Каждое состояние класса будет иметь уникальную копию этой переменной
#тут она локальная @ не особо выход из сессии там короче рельсы на crud основываются, тип девиз Create Read Update Delete а тут все рельсы на этом 