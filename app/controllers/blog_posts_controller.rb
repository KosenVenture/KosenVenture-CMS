# encoding: utf-8

class BlogPostsController < ApplicationController
  layout 'kvp'
  before_filter :load_categories

  def index
    @page_title = "ニュース"
    # カテゴリ別表示
    if params[:category_name]
      category = BlogCategory.find_by_name!(params[:category_name])
      @posts = category.posts.publishing
      @page_title = "#{category.title}｜#{@page_title}"
    else
      @posts = BlogPost.publishing
    end

    # 月別表示
    if params[:year] and params[:month]
      y = params[:year].to_i
      m = params[:month].to_i
      begin
        @posts = @posts.where('published_at >= ? AND published_at <= ?', Date.new(y, m, 1), Date.new(y, m, 1).end_of_month)
        @page_title = "#{ApplicationController.helpers.l(Date.new(y, m, 1), format: '%Y年%m月')}の記事｜#{@page_title}"
      rescue
        return render_404
      end
    end

    # 標準
    @posts = @posts.publishing.page(params[:page])

    @fb_ogp = {
      title: @page_title ? "#{@page_title}｜#{@site_config.title}" : @site_config.title,
      url: news_index_path,
      description: "高専ベンチャーの最新情報をお届けします。"
    }

    respond_to do |format|
      format.html { @posts = @posts.per(5) }
      format.atom { @posts = @posts.per(20) }
      format.json { @posts = @posts.per(10) }
    end
  end

  def show
    @post = BlogPost.includes(:author, :category).publishing.find(params[:id])
    @page_title = "#{@post.title}｜ニュース"

    @fb_ogp = {
      title: @page_title ? "#{@page_title}｜#{@site_config.title}" : @site_config.title,
      url: news_path(@post),
      description: ApplicationController.helpers.sanitize(@post.intro, tags: [], attributes: [])
    } unless @post.intro.blank?
  end

private

  def load_categories
    @categories = BlogPost.publishing.except(:order).group_by_category
    @monthly = BlogPost.monthly.sort.reverse
    @all_count = BlogPost.publishing.count
  end
end
