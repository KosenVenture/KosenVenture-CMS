KvpCms::Application.routes.draw do
  # 管理画面
  get '/admin' => 'admin#dashboard', as: 'admin'
  scope 'admin', module: :admin do
    resources :pages, except: [:show]
    resources :page_categories
    resources :users

    patch 'page_preview' => 'pages#preview'
  end

  # 任意のパスへのルーティング
  # ページを探す
  get '/*path' => 'page_navigation#navigate'

  # トップページ
  root to: 'page_navigation#navigate'
end
