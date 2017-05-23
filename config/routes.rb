Rails.application.routes.draw do
  root "pages#index"
  get '/add', :to => "pages#new"
  get '/*name/add', :to => "pages#new"
  get '/*name/edit', :to => "pages#edit"
  get '/*name/remove', :to => "pages#destroy"
  get '/*name', :to => "pages#show"
  post '/*name', :to => "pages#create"
  post '/', :to => "pages#create"
  patch '/*name', :to => "pages#update"
end
