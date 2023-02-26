Rails.application.routes.draw do

  devise_for :admins,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


  namespace :public do
    get 'customers' => "customers#show"
    get 'customers/edit'
    get 'customers/unsubscribe'
    patch 'customers' => 'customers#update'
  end

get '/admin' => 'admin/homes#top'

root to: 'public/homes#top'




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
