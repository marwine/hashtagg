require 'instagram'
require 'open-uri'
require 'openssl'

class FeedController < ApplicationController 
  
before_filter :authenticated, except: :index
caches_page :index

  def index 
    if session[:access_token] 
    redirect_to hashtags_url
    end
  end
    
  def photos
    load_api_data
  end

  def create
    load_api_data
    client = Instagram.client(:access_token => session[:access_token])  
    client.create_media_comment(params["id"], params["comment"])
    
    redirect_to photos_url
  end

  def create_mass_comments
    load_api_data
    client = Instagram.client(:access_token => session[:access_token])

    params[:image_ids].each do |image|
      client.create_media_comment(image, params["comment"])
    end

    redirect_to photos_url
  end

  def delete
    load_api_data
    client = Instagram.client(:access_token => session[:access_token])
    client.delete_media_comment(params['id'], params['format'])
    redirect_to photos_url
  end

end