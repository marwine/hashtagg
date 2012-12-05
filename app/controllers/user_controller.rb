class UserController < ApplicationController 
	def index
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @hashtagg_user = User.new
	end

	def create
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user    
    User.create(:full_name => @user["full_name"], :email => params[:email], :instagram_id => @user["id"])
    redirect_to albums_path
	end
end