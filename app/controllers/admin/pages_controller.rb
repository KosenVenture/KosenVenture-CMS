# encoding: utf-8

class Admin::PagesController < Admin::ApplicationController
  layout 'admin/pages'
  before_filter :authenticate_admin!
  before_filter :set_page, only: [ :show, :edit, :update, :destroy ]
  before_filter :set_associated_record, only: [ :new, :edit, :create, :update ]

  # GET /pages
  # GET /pages.json
  def index
    # 最近更新されたページを上位に表示
    @pages = Page.select_for_index.newest_updated_order
  end

  # PATCH /admin/page_preview
  def preview
    @page = Page.new(page_params)
    @site_config = SiteConfig.first

    render text: @page.body, layout: 'kvp'
  end

  # GET /pages/new
  def new
    @page = Page.new(published: true)
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to admin_pages_url, notice: "#{@page.title}を作成しました。" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update_attributes(page_params)
        expire_page @page.path # キャッシュを消去
        format.html { redirect_to admin_pages_url, notice: "#{@page.title}を更新しました。" }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    expire_page @page.path # キャッシュを消去
    respond_to do |format|
      format.html { redirect_to admin_pages_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :title, :description, :keywords, :body, :category_id, :author_id, :published, :published_at, :parent_id, :priority)
    end

    # ページ作成，編集に関連するデータの読み込み
    def set_associated_record
      @pages = Page.select_for_list.newest_updated_order
      @categories = PageCategory.select_for_list.newest_updated_order
      @users = User.select_for_list.newest_updated_order
    end
end
