require 'instagram'
require 'open-uri'
require 'openssl'
require 'enumerator'

class AlbumController < ApplicationController 
  
  def index    
  	client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @recent = client.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 60})['data']
    @page = client.user_recent_media['pagination']['next_url']
    
    # @popular = client.media_popular
    # @location_search = client.location_recent_media(514276)
	end
end