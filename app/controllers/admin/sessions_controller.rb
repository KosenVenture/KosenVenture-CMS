# encoding: utf-8

class Admin::SessionsController < ApplicationController
  layout 'admin'
  before_filter :redirect_if_authenticated, only: [ :new, :create ]

  def new
  end

  def create
    admin = User.find_by(name: params[:name])

    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_url, notice: 'ログインしました。'
    else
      flash.now.alert = "ログイン名もしくはパスワードが違います。"
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to admin_login_url, notice: '管理ページからログアウトしました。'
  end

  private

  def redirect_if_authenticated
    redirect_to admin_url, notice: '既にログインしています。' if current_admin
  end
end
