KvpCms::Application.routes.draw do
  # 管理画面
  get '/admin' => 'admin#dashboard', as: 'admin'
  scope 'admin', module: :admin do
    resources :pages
    resources :page_categories
    resources :users
  end

  # 任意のパスへのルーティング
  # ページを探す
  get '/*path' => 'page_navigation#navigate'

  # トップページ
  root to: 'page_navigation#navigate'
end
