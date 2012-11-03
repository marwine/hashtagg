require "instagram"

class SessionsController < ApplicationController

  def connect
        
    Instagram.configure do |config|
      config.client_id = CLIENT_ID
      config.client_secret = CLIENT_SECRET
    end
        
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)    
  end
  
  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect_to :controller => 'feed', :action => 'index'
  end
  
  def logout
  	session[:access_token] = nil
  	redirect_to :controller => 'feed', :action => 'index'
  end

end
