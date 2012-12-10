class UserController < ApplicationController 

  before_filter :authenticated

	def index
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @hashtagg_user = User.new
	end

	def create
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @user_data = params[:user]
    @new_user = User.create(:full_name => @user["full_name"], :email => @user_data["email"], :instagram_id => @user["id"])

    respond_to do |format|
      if @new_user.save
        format.html { redirect_to home_url, notice: 'Login successful.' }
      else
        format.html { redirect_to user_url, notice: 'Please enter a valid email address.'}
      end
    end
end

end