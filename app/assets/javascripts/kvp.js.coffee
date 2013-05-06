//= require jquery
//= require jquery_ujs
//= require bootstrap/bootstrap
//= require_self

rss_icon = $('#rss_icon')
rss_icon.empty()
rss_icon.append('<img src="/kvp/img/rss/' +  ( '0' + (Math.floor(Math.random() * 50) + 1)).slice(-2) + '.png" alt="RSSアイコン" />')