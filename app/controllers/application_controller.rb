class ApplicationController < ActionController::Base
  protect_from_forgery

  # määritellään, että metodit tulevat käyttöön myös näkymissä
  helper_method :current_user
  helper_method :current_is_admin
  
  def current_user
    return nil if session[:user_id].nil? 
    User.find(session[:user_id]) 
  end

  def current_is_admin
    return nil if session[:user_id].nil?
    u = User.find(session[:user_id])
    u.admin?
  end

  def ensure_that_signed_in 
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin 
    redirect_to signin_path, notice:'omg, you have no right!' if not current_user.admin?
  end
end
