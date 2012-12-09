InstahashOauth::Application.routes.draw do

  resources :albums

  root :to => 'feed#index'
  get '/index', :controller => "feed", :action => "index"

  match "session/:action", :to => "sessions"
  
  get '/photos' => 'feed#photos', :as => :photos
  get '/recent' => 'feed#recent', :as => :recent
  get '/show/:id' => 'feed#show', :as => :show

  get '/hashtags/:id' => 'hashtag#show', :as => :hashtag_show
  get '/hashtags' => 'hashtag#index', :as => :hashtags
  get '/hashtags/:id/create_album' => 'hashtag#create', :as => :create_album

  post '/photos/create_comment/:id' => 'feed#create', :as => :create_comment
  delete '/photos/delete_comment/:id' => 'feed#delete', :as => :delete_comment

  get '/user' => 'user#index', :as => :user
  post '/user' => 'user#create'

  get '/logout' => 'sessions#logout', :as => :logout
  get '/albums' => 'album#index', :as => :albums

end
  