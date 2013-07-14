# encoding: utf-8

class PageNavigationController < ApplicationController
  caches_page :navigate # ページキャッシュを取る
  before_filter :page_finder, only: [:navigate]
  layout 'kvp'

  def navigate
    @fb_ogp = { url: @page.path }

    render inline: @page.body, layout: true
  end

  private

  # ページを探す
  def page_finder
    if params[:path]
      @page = Page.published.find_by_path!('/' + params[:path])
    else
      # 空のときはindexページを探す
      @page = Page.published.find_by_path!('/index')
    end
  end
end
