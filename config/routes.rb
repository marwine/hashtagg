InstahashOauth::Application.routes.draw do

  
  root :to => 'hashtag#index'
  # get 'feed/index'

  match "session/:action", :to => "sessions"
  # match :controller => "sessions", :action => "connect"
  
  get '/index', :controller => "feed", :action => "index"
  # get '/home', :controller => 'feed', :action => 'home'
  get '/photos' => 'feed#home', :as => :photos
  get '/recent' => 'feed#recent', :as => :recent
  get '/show/:id' => 'feed#show', :as => :show

  get '/hashtags' => 'hashtag#index', :as => :home

  post '/home/create_comment/:id' => 'feed#create', :as => :create_comment
  delete '/home/delete_comment/:id' => 'feed#delete', :as => :delete_comment

  get '/user' => 'user#index', :as => :user
  post '/user' => 'user#create'

<<<<<<< HEAD
  get '/logout' => 'sessions#logout', :as => :logout
=======
  get '/albums' => 'album#index', :as => :albums
>>>>>>> c146599ddd1a701c2c8bf04329999bdfed8050c1

end
  