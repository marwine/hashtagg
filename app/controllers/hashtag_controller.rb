require 'instagram'
require 'open-uri'
require 'openssl'
#require 'enumerator'

class HashtagController < ApplicationController 
  
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

		#output format
		# [
		#  {:hashtag_value => "trees", :count => 4},
		#  {:hashtag_value => "christmas", :count => 3}
		# ]

		@all_tags_string = ""
		@tags_and_totals = Hash.new(0)
		@hashtag_data = Hash.new { |hash, key| hash[key] = Array.new }
		@temp_array = Array.new()
		@temp_hash = Hash.new()

		@recent.each do |tag|
			@all_tags_string = @all_tags_string + " " + tag['tags'].join(" ")
		end

		@all_tags = @all_tags_string.split(" ")
		# @tags = @all_tags.uniq

		@all_tags.each do |t|
		  @tags_and_totals[t] += 1
		end

		@all_tags.uniq.each do |t|
		  @recent.each do |r|
		  logger.debug "this is the value of r:  #{r}"
		  	r["tags"].each do |i|
		  logger.debug "this is the value of i:  #{i}"
		  		if i == t
		  			@hashtag_data[i] << r["images"]["standard_resolution"]["url"]
		  logger.debug "this is the value of @hashtag_data[i]:  #{@hashtag_data[i]}"
					else ""
					end
		  	end
		  end
		end

		#@data = Array.new

		# @hashtags_data.each do |i|
		# 	i[:tag].each do |j|
		# 		@data << {:tag => j}
		# 	end
		# end



		# @recent.each do |tag|
		# 	@all_tags_string = @all_tags_string + " " + tag['tags'].join(" ")
		# end


		# @hashtags_data = Array.new

		# @recent.each do |i|
		# 	@hashtags_data << {:image_url => i["images"]["standard_resolution"]["url"], :tag => ( i["tags"].empty? ?  [""] : i["tags"] ) }
		# end

		# @data = Array.new

		# @hashtags_data.each do |i|
		# 	i[:tag].each do |j|
		# 		@data << {:tag => j}
		# 	end
		# end

		# @group = @data.group_by {|i| i[:tag]}.count



  #   @all_tags_string = ""

		# @recent.each do |tag|
		# 	@all_tags_string = @all_tags_string + " " + tag['tags'].join(" ")
		# end

		# @all_tags = @all_tags_string.split(" ")
		# # @tags = @all_tags.uniq

		# @tags_and_totals = Hash.new(0)

		# @all_tags.each do |t|
		#   @tags_and_totals[t] += 1
		# end






	end

end

# [
# {:hashtag_value => "trees", :images => [trees1, trees2, trees3]},
# {:hashtag_value => "christmas", :images => [xmas1, xmas2, xmas3]}
# ]