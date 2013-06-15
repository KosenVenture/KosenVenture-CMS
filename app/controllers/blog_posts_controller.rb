# encoding: utf-8

class BlogPostsController < ApplicationController
  layout 'kvp'

  def index
    @posts = BlogPost.published.newest_published_order.page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.atom
      format.json
    end
  end

  def show
    @post = BlogPost.includes(:author, :category).find(params[:id])

    @page_title = @post.title

    @fb_ogp = {
      title: @page_title ? "#{@page_title}｜#{@site_config.title}" : @site_config.title,
      url: news_path(@post),
      description: @post.intro
    } unless @post.intro.blank?
  end
end
