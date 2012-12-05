require 'instagram'
require 'open-uri'
require 'openssl'
#require 'enumerator'

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
    
    @all_tags_string = ""

		@recent.each do |tag|
			@all_tags_string = @all_tags_string + " " + tag['tags'].join(" ")
		end

		@all_tags = @all_tags_string.split(" ")
		@tags = @all_tags.uniq

		@tags_and_totals = Hash.new(0)

		@all_tags.each do |t|
		  @tags_and_totals[t] += 1
		end

		# @tags.each do |t|
		# 	@exists = @recent['tags'].include? t
		# end
		
	end

end