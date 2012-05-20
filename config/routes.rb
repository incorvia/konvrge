Konvrge::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users

  resources :events, :questions, :answers, :photos

  resources :events do
    match '/photos', :to => 'photos#index', :sort => 'popular', :as => 'photos'
    match '/new_photos', :to => 'photos#index', :sort => 'new', :as => 'new_photos'
  end

  root :to => 'events#index', :category => nil, :sort => 'popular'
  match '/vote', :to => 'events#vote'
  match '/new', :to => 'events#index', :category => nil, :sort => 'new', :as => 'new_events'
  match '/c/:category(/:sort)', :to => 'events#index', :as => 'category'
end
