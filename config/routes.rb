KvpCms::Application.routes.draw do
  # CKEditor
  mount Ckeditor::Engine => '/ckeditor'

  # お問い合わせフォーム
  resource :contact, only: [ :show, :create ]
  # エントリーフォーム
  resource :event_entry, only: [ :create ]
  # ニュース
  resources :news, only: [ :show, :index ], controller: 'blog_posts' do
    collection do
      # カテゴリ別表示
      get '/categories/:category_name', constraints: {category_name: /[a-zA-Z0-9_\-]+/},
        controller: 'blog_posts',
        action: 'index',
        as: 'category'
      # 月別表示
      get '/:year/:month', constraints: {year: /[0-9]{4}/, month: /[0-1][0-9]/},
        controller: 'blog_posts',
        action: 'index',
        as: 'monthly'
    end
  end

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
    post 'blog_preview' => 'BlogPosts#preview'
    put 'blog_preview' => 'BlogPosts#preview'

    scope 'file_uploader' do
      get '(/*path)' => 'file_uploader#index', as: 'file_uploader'
      post '(/*path)/new_dir' => 'file_uploader#new_dir', as: 'uploader_new_dir'
      post '(/*path)' => 'file_uploader#upload'
      delete '(/*path)' => 'file_uploader#destroy'
    end

  end

  # 任意のパスへのルーティング
  # ページを探す
  get '/*path' => 'page_navigation#navigate'

  # トップページ
  root to: 'page_navigation#navigate'
end
