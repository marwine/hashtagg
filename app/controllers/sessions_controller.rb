require "instagram"
require "open-uri"
require "openssl"

class SessionsController < ApplicationController

  def connect 
    Instagram.configure do |config|
      config.client_id = CLIENT_ID
      config.client_secret = CLIENT_SECRET
    end
          
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL, :scope => "likes comments")
  end
  
  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token

    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user

    if User.find_by_instagram_id(@user['id'])
      redirect_to albums_path
    else
      redirect_to user_path
    end
  end
  
  def logout
    reset_session
  end
end
