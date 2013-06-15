# encoding: utf-8

class Admin::BlogCategoriesController < Admin::ApplicationController
  layout 'admin/pages'
  before_filter :authenticate_admin!
  load_and_authorize_resource
  
  before_filter :set_blog_category, only: [:show, :edit, :update, :destroy]

  def index
    @blog_categories = BlogCategory.newest_updated_order.page params[:page]
  end

  def new
    @blog_category = BlogCategory.new
  end

  def edit
  end

  def create
    @blog_category = BlogCategory.new(blog_category_params)

    respond_to do |format|
      if @blog_category.save
        format.html { redirect_to admin_blog_categories_url, notice: "#{@blog_category.title}を作成しました。" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog_category.update_attributes(blog_category_params)
        format.html { redirect_to admin_blog_categories_url, notice: "#{@blog_category.title}を更新しました。" }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @blog_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_blog_categories_url }
    end
  end

  private
    def set_blog_category
      @blog_category = BlogCategory.find(params[:id])
    end

    def blog_category_params
      params.require(:blog_category).permit(:name, :title)
    end
end
