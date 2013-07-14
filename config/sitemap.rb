# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.kosen-venture.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  add contact_path, priority: 0.1, changefreq: 'monthly'

  add news_index_path, priority: 0.3, changefreq: 'weekly'
  BlogPost.publishing.each do |post|
    add news_path(post), lastmod: post.updated_at, priority: 0.4, changefreq: 'weekly'
  end

  Page.published.each do |page|
    add page.path, lastmod: page.updated_at, priority: page.priority, changefreq: 'weekly'
  end
end
