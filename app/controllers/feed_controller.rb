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
    @recent = client.user_recent_media  
    @popular = client.media_popular
    @location_search = client.location_recent_media(514276)
  end

  def show
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @media = client.media_item(params[:id])

  end

  def recent
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @user_recent_media = client.tag('Chitown')
  end
  
  
end