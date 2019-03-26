Rails.application.routes.draw do
  resources :urls
  resources :contents
  resources :content_types
  resources :pages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
