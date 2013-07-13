# encoding: utf-8

atom_feed(language: 'ja-JP', root_url: root_url, id: root_url, url: news_index_url(:atom)) do |feed|
  feed.title '高専ベンチャー ニュースフィード'
  feed.updated(@posts.first.updated_at) unless @posts.empty?
  feed.author{|author| author.name('高専ベンチャー運営') }

  @posts.each do |post|
    feed.entry(post,
      id: post.id,
      url: news_url(post),
      published: post.published_at,
      updated: post.updated_at) do |entry|

      entry.title post.title
      entry.content post.intro + "<br /><a href=\"#{news_url(post)}\">続きを読む&gt;&gt;</a>", type: :html
      entry.author {|author| author.name(post.author.real_name) }
    end
  end
end