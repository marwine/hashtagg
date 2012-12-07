# require 'instagram'
# require 'open-uri'
# require 'openssl'

# class AlbumController < ApplicationController 

# def index    
#   	client = Instagram.client(:access_token => session[:access_token])
#     @user = client.user
    
#     @recent = []
#     @page = "https://api.instagram.com/v1/jett/media/recent?access_token=#{client.access_token}&count=60"
#     @pagination_call = "bogus"

#     while @pagination_call != nil do
#       @response = open(@page, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
#       @recent = @recent + JSON.parse(@response)["data"]
#       @pagination_call = JSON.parse(@response)["pagination"]["next_url"]
#       @page = "#{@pagination_call}&count=60"
#     end

#     @images

# 	end

# end

require 'instagram'
require 'open-uri'
require 'openssl'

class AlbumController < ApplicationController 

	def index    
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

		@tag_value = "jett"
		@album_data = Array.new

	  @recent.each do |r|
	  	r["tags"].each do |i|
	  		if i == @tag_value
	  			@album_data << r["images"]["standard_resolution"]["url"]
				else ""
				end
				
	  	end
	  end

	end

end