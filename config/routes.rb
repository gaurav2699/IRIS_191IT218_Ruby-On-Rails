Rails.application.routes.draw do
  devise_for :users, controllers: {
registrations: 'registrations'
   }
  resources :products
  root 'products#index'
  match 'products/:id/buy' => 'products#buy', :as => :buy, via: :get

#  match 'products/buy' => 'products#buy', :as => :buy, via: :post
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
