class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.json
  def index
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user

    @user_id = User.find_by_instagram_id(@user["id"])["id"]
    @albums = Album.find_all_by_user_id(@user_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album_name = params[:id]
    @album = Album.where("name = '#{@album_name}'")

    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user

    # @albums = Album.all
    # @user_id = User.find_by_instagram_id(@user["id"])["id"]
    # @album = Album.where(:user_id == @user_id)

    @recent = []
    @page = "https://api.instagram.com/v1/users/#{@user["id"]}/media/recent?access_token=#{client.access_token}&count=60"
    @pagination_call = "bogus"

    while @pagination_call != nil do
      @response = open(@page, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
      @recent = @recent + JSON.parse(@response)["data"]
      @pagination_call = JSON.parse(@response)["pagination"]["next_url"]
      @page = "#{@pagination_call}&count=60"
    end   

    @album_data = Array.new []

    @recent.each do |instagram_record|
      instagram_record["tags"].each do |tag|
        @album.each do |one_album|
          if tag == one_album["tag"]
            @album_data << instagram_record["images"]["standard_resolution"]["url"]
          else ""
          end
        end
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    @album = params[:album]
    @user_id = User.find_by_instagram_id(@user["id"])["id"]

    @new_album = Album.new(:name => @album['name'], :tag => @album['tag'], :user_id => @user_id)

    respond_to do |format|
      if @new_album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
