# encoding: utf-8

class BlogPostsController < ApplicationController
  layout 'kvp'
  before_filter :load_categories

  def index
    # カテゴリ別表示
    if params[:category_name]
      category = BlogCategory.find_by_name!(params[:category_name])
      @posts = category.posts.publishing
    else
      @posts = BlogPost.publishing
    end

    # 月別表示
    if params[:year] and params[:month]
      y = params[:year].to_i
      m = params[:month].to_i
      begin
        @posts = @posts.where('published_at >= ? AND published_at <= ?', Date.new(y, m, 1), Date.new(y, m, 1).end_of_month)
      rescue
        return render_404
      end
    end

    # 標準
    @posts = @posts.publishing.page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.atom
      format.json
    end
  end

  def show
    @post = BlogPost.includes(:author, :category).publishing.find(params[:id])

    @page_title = @post.title

    @fb_ogp = {
      title: @page_title ? "#{@page_title}｜#{@site_config.title}" : @site_config.title,
      url: news_path(@post),
      description: @post.intro
    } unless @post.intro.blank?
  end

private

  def load_categories
    @categories = BlogPost.publishing.except(:order).group_by_category
    @monthly = BlogPost.monthly.sort.reverse
    @all_count = BlogPost.publishing.count
  end
end
