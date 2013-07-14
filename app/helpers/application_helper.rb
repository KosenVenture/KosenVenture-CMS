# encoding: utf-8

module ApplicationHelper
  def site_title
    # ページのときは自動セット
    if @page
      @page_title = @page.title
    end
    @page_title.blank? ? @site_config.title : "#{@page_title}｜#{@site_config.title}"
  end

  def site_description
    if @page.nil? || @page.description.blank?
      if @page_description
        @page_description
      else
        @site_config.description
      end
    else
      @page.description
    end
  end

  def site_keywords
    if @page.nil? || @page.keywords.blank?
      @site_config.keywords
    else
      @page.keywords
    end
  end

  def sortable_link(title, column, params)
    order = params[:order]
    desc = params[:desc]

    icon_class = (desc == 'true' ? 'icon-arrow-up' : 'icon-arrow-down')
    icon = (order == column ? icon_tag(icon_class) : '')

    link_to raw(icon + title),
      order: column,
      desc: (desc == 'true' ? 'false' : 'true')
  end
end
