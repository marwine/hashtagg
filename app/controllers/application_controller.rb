class ApplicationController < ActionController::Base

private

  protect_from_forgery
  
  def load_api_data

	  client = Instagram.client(:access_token => session[:access_token])
	  @user = client.user

	  logger.debug "this process is calling the api"

	  @recent = []
	  @page = "https://api.instagram.com/v1/users/#{@user["id"]}/media/recent?access_token=#{client.access_token}&count=60"
	  @pagination_call = "bogus"

	  while @pagination_call != nil do
	    @response = open(@page, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
	    @recent = @recent + JSON.parse(@response)["data"]
	    @pagination_call = JSON.parse(@response)["pagination"]["next_url"]
	    @page = "#{@pagination_call}&count=60"
	  end

	  # if comment count is greater than 8, replace comments in @recent with full comment list
	  @recent.each do |instagram_record|
	    if instagram_record["comments"]["count"] > 8
	      @page = "https://api.instagram.com/v1/media/#{instagram_record['id']}/comments?access_token=#{client.access_token}&count=60"
	      @response = open(@page, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read          
	      instagram_record["comments"]["data"] = JSON.parse(@response)["data"]
	    end
	  end

	  # if likes count is greater than 10, replace comments in @recent with full comment list
	  @recent.each do |instagram_record|
	    if instagram_record["comments"]["count"] > 8
	      @page = "https://api.instagram.com/v1/media/#{instagram_record['id']}/likes?access_token=#{client.access_token}&count=60"
	      @response = open(@page, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read          
	      instagram_record["likes"]["data"] = JSON.parse(@response)["data"]
	    end
	  end

	end

	def logged_in?
		session[:access_token] ? true : false
	end

	def authenticated
		if logged_in? == false
			redirect_to root_url
		end
	end

end