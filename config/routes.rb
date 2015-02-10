Rails.application.routes.draw do
  #, :path => "", :constraints => {:subdomain => "api"}
#namespace :api do
  namespace :v1, defaults: {format: 'json'} do
    resources :user
    resources :orders, except: [:new, :edit] do 
      resources :item_lines, except: [:new, :edit]
      resources :status_transitions, only: [:index, :update]
    end
    resources :products, except: [:new, :edit]
  end
#end
end
