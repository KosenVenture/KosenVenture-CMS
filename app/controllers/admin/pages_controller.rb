# encoding: utf-8

class Admin::PagesController < ApplicationController
  layout 'admin/pages'
  before_action :authenticate_admin!
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
  end

  # PATCH /admin/page_preview
  def preview
    @page = Page.new(page_params)

    render text: @page.body, layout: 'kvp'
  end

  # GET /pages/new
  def new
    @pages = Page.all
    @page = Page.new(published: true)
    @categories = PageCategory.all
    @users = User.all
  end

  # GET /pages/1/edit
  def edit
    @pages = Page.all
    @categories = PageCategory.all
    @users = User.all
  end

  # POST /pages
  # POST /pages.json
  def create
    @pages = Page.all
    @page = Page.new(page_params)
    @categories = PageCategory.all
    @users = User.all

    respond_to do |format|
      if @page.save
        format.html { redirect_to pages_url, notice: "#{@page.title}を作成しました。" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @pages = Page.all
    @categories = PageCategory.all
    @users = User.all

    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to pages_url, notice: "#{@page.title}を更新しました。" }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :title, :description, :body, :category_id, :author_id, :published, :published_at, :parent_id)
    end
end
