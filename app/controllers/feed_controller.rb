require 'instagram'
require 'open-uri'
require 'openssl'

class FeedController < ApplicationController 
  
  def index 
    if session[:access_token] 
      redirect_to :controller=>'feed', :action=>'home'
    end
  end
    
  def home
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user

    @recent = []
    @page = "https://api.instagram.com/v1/users/#{@user["id"]}/media/recent?access_token=#{client.access_token}&count=60"
    @pagination_call = "bogus"

    while @pagination_call != nil do
      @response = open(@page, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
      @recent = @recent + JSON.parse(@response)["data"]
      @pagination_call = JSON.parse(@response)["pagination"]["next_url"]
      @page = "#{@pagination_call}&count=60"
    end
  end

  def create
    client = Instagram.client(:access_token => session[:access_token])
    client.create_media_comment(params["id"], params["comment"])
    redirect_to :controller=>'feed', :action=>'home'
  end

  def show
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @media = client.media_item(params[:id])
  end

  def delete
    client = Instagram.client(:access_token => session[:access_token])
    client.delete_media_comment(params['id'], params['format'])
    redirect_to :controller=>'feed', :action=>'home'
  end

  def recent
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @user_recent_media = client.tag('Chitown')
  end
end