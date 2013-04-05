# encoding: utf-8

class Admin::PageCategoriesController < ApplicationController
  layout 'admin/pages'
  before_action :authenticate_admin!
  before_action :set_page_category, only: [:show, :edit, :update, :destroy]

  # GET /page_categories
  # GET /page_categories.json
  def index
    @page_categories = PageCategory.all
  end

  # GET /page_categories/new
  def new
    @page_category = PageCategory.new
  end

  # GET /page_categories/1/edit
  def edit
  end

  # POST /page_categories
  # POST /page_categories.json
  def create
    @page_category = PageCategory.new(page_category_params)

    respond_to do |format|
      if @page_category.save
        format.html { redirect_to page_categories_url, notice: "#{@page_category.title}を作成しました。" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /page_categories/1
  # PATCH/PUT /page_categories/1.json
  def update
    respond_to do |format|
      if @page_category.update(page_category_params)
        format.html { redirect_to page_categories_url, notice: "#{@page_category.title}を更新しました。" }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /page_categories/1
  # DELETE /page_categories/1.json
  def destroy
    @page_category.destroy
    respond_to do |format|
      format.html { redirect_to page_categories_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_category
      @page_category = PageCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_category_params
      params.require(:page_category).permit(:name, :title)
    end
end
