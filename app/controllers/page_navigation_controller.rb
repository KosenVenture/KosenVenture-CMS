# encoding: utf-8

class PageNavigationController < ApplicationController
  caches_page :navigate # ページキャッシュを取る
  before_filter :page_finder, only: [:navigate]
  layout 'kvp'

  def navigate
    @site_title = '高専ベンチャー'
    @page_title = @page.title
    # descriptionがセットされている場合はfbのリンクをページに
    @fb_ogp = {
      title: @page_title ? "#{@page_title}｜#{@site_title}" : @site_title,
      url: @page.path,
      description: @page.description
    } unless @page.description.blank?

    render text: @page.body, layout: true
  end

  private

  # ページを探す
  def page_finder
    if params[:path]
      names = params[:path].split('/')
      @page = names.inject(nil) { |page, name| (page ? page.children.find_by_name!(name) : Page.published.find_by_name!(name)) }

      raise unless @page.path == ('/' + params[:path])
    else
      # 空のときはindexページを探す
      @page = Page.published.find_by_name!('index')
    end
  rescue
    # ページが見つからない場合は404
    render 'shared/404', status: '404'
  end
end
