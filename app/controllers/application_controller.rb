class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :load_site_config

  # ActiveRecord::RecordNotFound のときは、404エラーページに
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private
  def load_site_config
    @site_config = SiteConfig.first
  end

  # 404ページを表示する
  def render_404
    # ページが見つからない場合は404
    render 'shared/404', status: '404'
  end
end
