# encoding: utf-8

PublicActivity.enabled = false

# 初期管理ユーザの作成
User.create!(name: 'admin', real_name: '管理者',
  password: 'admin', password_confirmation: 'admin', role: 'admin')
# SiteConfigの作成
SiteConfig.create!(title: "", description: "", keywords: "")
