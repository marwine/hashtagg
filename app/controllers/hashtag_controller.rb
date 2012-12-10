require 'instagram'
require 'open-uri'
require 'openssl'

class HashtagController < ApplicationController 
  
before_filter :authenticated

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
		@tags_and_totals = Hash.new(0)
		@hashtag_data = Hash.new { |hash, key| hash[key] = Array.new }
		@temp_array = Array.new()
		@temp_hash = Hash.new()

		@recent.each do |tag|
			@all_tags_string = @all_tags_string + " " + tag['tags'].join(" ")
		end

		@all_tags = @all_tags_string.split(" ")

		@all_tags.each do |t|
		  @tags_and_totals[t] += 1
		end

		@all_tags.uniq.each do |t|
		  @recent.each do |r|
		  	r["tags"].each do |i|
		  		if i == t
		  			@hashtag_data[i] << r["images"]["standard_resolution"]["url"]
					else ""
					end
		  	end
		  end
		end
	end

	def create
		load_api_data
    @user_id = User.find_by_instagram_id(@user["id"])["id"]
    @tag = params[:id]

    @album = Album.new(:name => "#{@tag}", :tag => @tag, :user_id => @user_id)    

    respond_to do |format|
      if @album.save
      	@album_id = Album.find_by_tag(@tag)['id']
        format.html { redirect_to album_url(@album_id), notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
	end
	
	def show
		load_api_data
    @tag = params[:id]
    @filmstrip_data = Array.new []

    @recent.each do |instagram_record|
      instagram_record["tags"].each do |tag|
        if tag == @tag
          @filmstrip_data << instagram_record	
        else ""
        end
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @album }
    end
  end
  
end