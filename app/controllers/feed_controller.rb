require 'instagram'

class FeedController < ApplicationController 
  
  def index    
    if session[:access_token] 
      redirect_to :controller=>'feed', :action=>'home'
    end
  end
    
  def home  
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @user_recent_media = client.user_recent_media  
    @popular = client.media_popular
    @location_search = client.location_recent_media(514276)
  end

  def recent
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @user_recent_media = client.tag_recent_media('nofilter')
  end
  
  
end