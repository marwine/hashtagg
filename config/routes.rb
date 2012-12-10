InstahashOauth::Application.routes.draw do

  root :to => 'feed#index'
  match "session/:action", :to => "sessions"
  get '/logout' => 'sessions#logout', :as => :logout

  resources :albums
  
  get '/hashtags' => 'hashtag#index', :as => :hashtags
  get '/hashtags/:id' => 'hashtag#show', :as => :hashtag_show
  get '/hashtags/:id/create_album' => 'hashtag#create', :as => :create_album

  get '/index' => "feed#index", :to => :index
  get '/photos' => 'feed#photos', :as => :photos
  post '/photos/create_mass_comments' => 'feed#create_mass_comments', :as => :create_mass_comments
  post '/photos/:id/create_comment' => 'feed#create', :as => :create_comment
  delete '/photos/:id/delete_comment' => 'feed#delete', :as => :delete_comment

  get '/user' => 'user#index', :as => :user
  post '/user' => 'user#create'

end
  