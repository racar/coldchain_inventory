Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :orders
  resources :members
  resources :users
  resources :items
  resources :institucions


  root 'orders#index'
  get 'renew/:id' => 'orders#renew'
  get 'return/:id' => 'orders#disable'
  get 'past_orders' => 'orders#old'

  post '/items/getMarcas' => 'items#getMarcas', as: :getMarcas
  post '/items/getModelos' => 'items#getModelos', as: :getModelos

  get '/mantenimientos/export_excel' =>'mantenimientos#export_excel', as: :export_excel_gesta
  resources :mantenimientos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
