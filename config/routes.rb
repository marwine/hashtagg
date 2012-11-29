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
  get '/home/test' => 'feed#test', :as => :test

  get '/albums' => 'album#index', :as => :albums

end
  