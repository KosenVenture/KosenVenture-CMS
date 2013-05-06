# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.kosen-venture.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add contact_path, priority: 0.1, changefreq: 'monthly'

  add news_index_path, priority: 0.3, changefreq: 'weekly'
  BlogPost.published.each do |post|
    add news_path(post), lastmod: post.updated_at, priority: 0.5, changefreq: 'weekly'
  end

  Page.published.each do |page|
    add page.path, lastmod: page.updated_at, priority: page.priority, changefreq: 'weekly'
  end
end
