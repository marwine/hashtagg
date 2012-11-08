require 'instagram'
# require 'open-uri'
# require 'openssl'

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
    # @resource_url = "https://api.instagram.com/v1/users/#{@user.id}/media/recent?access_token=#{session[:access_token]}"
    # @response = open(@resource_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
    # @get_pagination = JSON.parse(@response)
    # @get_next_url = @get_pagination["pagination"]["next_url"]

    # u = IUser.new
    # u.username = client.user.username
    # u.fullname = client.user.full_name 
    # if u.new_record?
    # u.save
    # end
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