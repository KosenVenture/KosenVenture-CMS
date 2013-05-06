# encoding: utf-8

class Admin::BlogPostsController < Admin::ApplicationController
  layout 'admin/pages'
  before_filter :authenticate_admin!
  before_filter :set_post, only: [ :show, :edit, :update, :destroy ]
  before_filter :set_associated_record, only: [ :new, :edit, :create, :update ]

  def index
    # ソート順の指定に従う
    if params[:order]
      order_str = params[:order] + (params[:desc] == 'true' ? ' DESC' : '')
      @posts = BlogPost.includes(:author, :category).select_for_index.order(order_str)
    else
      # 最近更新されたページを上位に表示
      @posts = BlogPost.includes(:author, :category).select_for_index.newest_updated_order
    end
  end

  def preview
    @post = BlogPost.new(post_params)
    @site_config = SiteConfig.first

    #render '', layout: 'kvp'
  end

  def new
    @post = BlogPost.new(published: true)
  end

  def edit
  end

  def create
    @post = BlogPost.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_admin_blog_post_url(@post), notice: "#{@post.title}を作成しました。" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(post_params)

        format.html { redirect_to edit_admin_blog_post_url(@post), notice: "#{@post.title}を更新しました。" }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to admin_blog_posts_url }
    end
  end

  private
    def set_post
      @post = BlogPost.find(params[:id])
    end

    def post_params
      params.require(:blog_post).permit(:title, :intro, :body, :category_id, :author_id, :published, :published_at)
    end

    # ページ作成，編集に関連するデータの読み込み
    def set_associated_record
      @posts = BlogPost.select_for_list.newest_updated_order
      @categories = BlogCategory.select_for_list.newest_updated_order
      @users = User.select_for_list.newest_updated_order
    end
end
