//= require jquery
//= require jquery_ujs
//= require bootstrap/bootstrap
//= require_self

rss_icon = $('#rss_icon')
rss_icon.empty()
rss_icon.append('<img src="/kvp/img/rss/' +  ( '0' + (Math.floor(Math.random() * 50) + 1)).slice(-2) + '.png" alt="RSSアイコン" />')

ToSimpleDateString = (date) ->
  return date.getFullYear() + '年' + (date.getMonth() + 1) + '月' + date.getDate() + '日'

# News list
if $('div#news_list').length != 0
  category = $('div#news_list').data("category")
  path = if category then "/news/categories/#{category}.json" else "/news.json"

	$.getJSON path, (posts) ->
		$('div#news_list').append('<ul class="unstyled"></ul>')
		list_dom = $('div#news_list > ul')
		for i of posts
			list_dom.append '<li><span class="label label-info">' +
        posts[i]['category_name'] + '</span>&nbsp;<a href="/news/' +
        posts[i]['id'] + '">' + posts[i]['title'] + '</a>&nbsp;<span class="label">' +
        ToSimpleDateString(new Date(posts[i]['published_at'])) + '</span></li>'

