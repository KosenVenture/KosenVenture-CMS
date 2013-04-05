# encoding: utf-8

class PageNavigationController < ApplicationController
  before_filter :page_finder, only: [:navigate]
  layout 'kvp'

  def navigate
    @site_title = '高専ベンチャー'
    @page_title = @page.title

    render text: @page.body, layout: true
  end

  private

  # ページを探す
  def page_finder
    if params[:path]
      names = params[:path].split('/')
      @page = names.inject(nil) { |page, name| (page ? page.children.find_by!(name: name) : Page.find_by!(name: name)) }

      raise unless @page.path == ('/' + params[:path])
    else
      # 空のときはindexページを探す
      @page = Page.find_by!(name: 'index')
    end
  rescue
    # ページが見つからない場合は404
    render file: "#{ENV['RAILS_ROOT']}/public/404.html",
      status: '404',
      layout: false
  end
end
