Rails.application.routes.draw do

  jsonapi_resources :pages
  jsonapi_resources :contents #Optional
  jsonapi_resources :urls #Optional
  jsonapi_resources :content_types #Optional

end
