KvpCms::Application.routes.draw do

  # お問い合わせフォーム
  resource :contact, only: [ :show, :create ]

  # 管理画面
  get '/admin/login' => 'admin/sessions#new', as: 'admin_login'
  namespace :admin do
    resource :session, only: [ :new, :create, :destroy ]
  end
  get '/admin' => 'admin#dashboard', as: 'admin'
  scope 'admin', module: :admin do
    resources :pages, except: [ :show ]
    resources :page_categories, except: [ :show ]
    resources :users, except: [ :show ]

    # 作成と編集でpostとpatchが変わってしまうので・・・
    post 'page_preview' => 'pages#preview'
    put 'page_preview' => 'pages#preview'
  end

  # 任意のパスへのルーティング
  # ページを探す
  get '/*path' => 'page_navigation#navigate'

  # トップページ
  root to: 'page_navigation#navigate'
end
