Rails.application.routes.draw do
  # Have no idea how to add infinite routes with resource policies
  # Root routes
  root to: 'pages#index'
  get '/add', to: 'pages#new'
  get '/edit', to: 'pages#edit'
  post '/', to: 'pages#create'
  patch '/', to: 'pages#update'
  delete '/', to: 'pages#destroy'

  # Pages routes
  get '/*page_path/add', to: 'pages#new'
  get '/*page_path/edit', to: 'pages#edit'
  get '/*page_path', to: 'pages#show'
  post '/*page_path', to: 'pages#create'
  patch '/*page_path', to: 'pages#update'
  delete '/*page_path', to: 'pages#destroy'


  # resources :pages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
