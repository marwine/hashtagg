class AlbumsController < ApplicationController

before_filter :authenticated

  def index
    load_api_data
    @user_id = User.find_by_instagram_id(@user["id"])["id"]
    @albums = Album.find_all_by_user_id(@user_id)

    # @album_data = Hash.new { |hash, key| hash[key] = Array.new }
    @albums_array = Array.new

    @albums.each do |album|  #   album => jett
      @album_data = Hash.new { |hash, key| hash[key] = Array.new }  #new record
      @recent.each do |instagram_record| #   |ir|tags => jett, hudson
        instagram_record["tags"].each do |tag|  #   tag => jett then loop and do tag => hudson
          if tag == album["tag"]  #  if jett == Jett
            @album_data["images"] << instagram_record["images"]["standard_resolution"]["url"]
          else ""
          end
        end
      end
        @album_data["id"] = album["id"]
        @album_data["tag"] = album["tag"]
        @album_data["name"] = album["name"]
        if @album_data.has_key?("images") == false
          @album_data["images"] = ["http://upload.wikimedia.org/wikipedia/commons/3/3d/Charaxes_brutus_natalensis.jpg"]
        end  
        @albums_array << @album_data
    end

    respond_to do |format|
      format.html
      format.json { render json: @albums }
    end
  end

  def show
    load_api_data
    @album = Album.find_by_id(params[:id])

    @album_data = Array.new []

    @recent.each do |instagram_record|
      instagram_record["tags"].each do |tag|
        if tag == @album["tag"]
          @album_data << instagram_record
        else ""
        end
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @album }
    end
  end

  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  def create
    load_api_data
    @album_data = params[:album]
    @user_id = User.find_by_instagram_id(@user["id"])["id"]

    if @album_data['tag'][0] == "#"
      @tag = @album_data['tag'].split("#").last
    else
      @tag = @album_data['tag']
    end

    @album = Album.new(:name => @album_data['name'], :tag => @tag, :user_id => @user_id)

    respond_to do |format|
      if @album.save
        format.html { redirect_to albums_url, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album = Album.find_by_id(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
