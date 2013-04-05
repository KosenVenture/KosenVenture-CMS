# encoding: utf-8

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private

  def authenticate_admin!
    redirect_to admin_login_url, alert: '認証が必要です' unless session[:admin_id]
  end

  def current_admin
    @current_admin ||= User.find(session[:admin_id]) if session[:admin_id]
  end

  helper_method :current_admin
end
