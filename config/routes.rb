KvpCms::Application.routes.draw do
  # CKEditor
  mount Ckeditor::Engine => '/ckeditor'

  # お問い合わせフォーム
  resource :contact, only: [ :show, :create ]
  # エントリーフォーム
  resource :event_entry, only: [ :create ]
  # ニュース
  resources :news, only: [ :show, :index ], controller: 'blog_posts'

  # 管理画面
  get '/admin/login' => 'admin/sessions#new', as: 'admin_login'
  get '/admin' => 'admin/admin#dashboard', as: 'admin'

  namespace :admin do
    resource :session, only: [ :new, :create, :destroy ]

    resources :pages, except: [ :show ]
    resources :page_categories, except: [ :show ]
    resources :users, except: [ :show ]
    resource :site_config, only: [ :show, :create, :update ]
    resources :blog_posts, except: [ :show ]
    resources :blog_categories, except: [ :show ]

    # 作成と編集でpostとputが変わってしまうので・・・
    post 'page_preview' => 'pages#preview'
    put 'page_preview' => 'pages#preview'
  end

  # 任意のパスへのルーティング
  # ページを探す
  get '/*path' => 'page_navigation#navigate'

  # トップページ
  root to: 'page_navigation#navigate'
end
