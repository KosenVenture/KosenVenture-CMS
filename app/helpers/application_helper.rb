# encoding: utf-8

module ApplicationHelper
  def site_title
    @page_title.blank? ? @site_config.title : "#{@page_title}｜#{@site_config.title}"
  end

  def site_description
    if @page.nil? || @page.description.blank?
      @site_config.description
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
end
