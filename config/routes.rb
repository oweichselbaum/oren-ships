Rails.application.routes.draw do
  namespace :admin do
    resources :products
    get '/products/measurements/:length/:width/:height/:weight' => 'products#calculate_measurements_match'
  end
  match "/404" => "errors#not_found", via: [ :get, :post, :patch, :delete, :put ]
  match "/500" => "errors#exception", via: [ :get, :post, :patch, :delete, :put ]

  match "/api/v1/products" => "admin/products#index", via: [:get], :defaults => { :format => 'json' }
  match "/api/v1/products" => "admin/products#create", via: [:post], :defaults => { :format => 'json' }
  match "/api/v1/products/:id" => "admin/products#update", via: [:patch, :put], :defaults => { :format => 'json' }
  match "/api/v1/products/:id" => "admin/products#destroy", via: [:delete], :defaults => { :format => 'json' }
  match "/api/v1/products/:id" => "admin/products#show", via: [:get], :defaults => { :format => 'json' }
  match "/api/v1/products/measurements/:length/:width/:height/:weight" => "admin/products#calculate_measurements_match", via: [:get], :defaults => { :format => 'json' }

  root :to => "welcome#index"

end
