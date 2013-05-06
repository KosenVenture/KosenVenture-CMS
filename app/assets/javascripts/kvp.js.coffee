//= require jquery
//= require jquery_ujs
//= require bootstrap/bootstrap
//= require_self

rss_icon = $('#rss_icon')
rss_icon.empty()
rss_icon.append('<img src="/kvp/img/rss/' +  ( '0' + (Math.floor(Math.random() * 50) + 1)).slice(-2) + '.png" alt="RSSアイコン" />')

$.getJSON "/news.json", (posts) ->
  $('div#news_list').append('<ul></ul>')
  list_dom = $('div#news_list > ul')
  for i of posts
    list_dom.append '<li><a href="/news/' + posts[i]['id'] + '">' + posts[i]['title'] + '</a></li>'

