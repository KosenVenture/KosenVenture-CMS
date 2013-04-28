# encoding: utf-8

class Admin::SiteConfigsController < Admin::ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def show
    @config = SiteConfig.first_or_initialize
  end

  def create
    @config = SiteConfig.new(config_params)

    respond_to do |format|
      if @config.save
        Page.all.each do |p|
          expire_page p.path # キャッシュを消去
        end

        format.html {
          redirect_to admin_site_config_url,
            notice: 'サイト設定を更新しました。'
        }
      else
        format.html { render action: 'show' }
      end
    end
  end

  def update
    respond_to do |format|
      @config = SiteConfig.first

      if @config.update_attributes(config_params)
        Page.all.each do |p|
          expire_page p.path # キャッシュを消去
        end

        format.html { redirect_to admin_site_config_url,
          notice: "サイト設定を更新しました。" }
      else
        format.html { render action: 'show' }
      end
    end
  end

  private

  def config_params
    params.require(:site_config).permit(:title, :description, :keywords)
  end
end
