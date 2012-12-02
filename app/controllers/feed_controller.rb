require 'instagram'
require 'kaminari'
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

    # @recent = Kaminari.paginate_array(c).page(params[:page]).per(60)
    #@recent = Instagram.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 60})['data']
    
    #@recent = client.user_recent_media(@user['id'], {:access_token => session[:access_token], :count => 60})['data']

    # @recent = client.user_recent_media['data']
    # @resource_url = "https://api.instagram.com/v1/users/#{@user.id}/media/recent?access_token=#{session[:access_token]}"
    # @response = open(@resource_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
    # @get_next_url = @get_pagination["pagination"]["next_url"]
    
    # @location_search = client.location_recent_media(514276)
    # @popular = client.media_popular

    # u = IUser.new
    # u.username = client.user.username
    # u.fullname = client.user.full_name 
    # if u.new_record?
    # u.save
    # end
  end

  def create
    redirect_to create_comment_url, :notice => "#{params[:comment]}#{params[:id]}"
  end

  def test
    @resource_url = @page
    @json = JSON.parse(open(@resource_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)    
    @recent = @json['data']

    # client = Instagram.client(:access_token => session[:access_token])
    # @user = client.user
    # @json = open(@resource_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read    
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