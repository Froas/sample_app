module SessionsHelper

  # Осуществляет вход данного пользователя.
  def log_in(user)
    session[:user_id] = user.id
  end

  def store_location
    session[:return_to] = request.fullpath

    def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

 end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember,cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    current_user == user 
  end
end