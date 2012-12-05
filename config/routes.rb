InstahashOauth::Application.routes.draw do

  
  root :to => 'feed#index'
  # get 'feed/index'

  match "session/:action", :to => "sessions"
  # match :controller => "sessions", :action => "connect"
  
  get '/index', :controller => "feed", :action => "index"
  # get '/home', :controller => 'feed', :action => 'home'
  get '/home' => 'feed#home', :as => :home
  get '/recent' => 'feed#recent', :as => :recent
  get '/show/:id' => 'feed#show', :as => :show

  get '/hashtags' => 'hashtag#index', :as => :albums
  post '/home/create_comment/:id' => 'feed#create', :as => :create_comment
  delete '/home/delete_comment/:id' => 'feed#delete', :as => :delete_comment

  get '/user' => 'user#index', :as => :user
  post '/user' => 'user#create'

  get '/logout' => 'sessions#logout', :as => :logout

end
  