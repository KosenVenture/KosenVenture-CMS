# encoding: utf-8

# 初期管理ユーザの作成
User.create!(name: 'admin', real_name: '管理者',
  password: 'admin', password_confirmation: 'admin')