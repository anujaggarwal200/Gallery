class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @published_albums =current_user.albums.where(publish: true)
    @unpublished_albums = current_user.albums.where(publish: false)
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = current_user.albums.build
  end

  def create
    @album = current_user.albums.build(album_params)

    if @album.save
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to @album
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to root_path, status: :see_other
  end

  def purge_image
    img=ActiveStorage::Attachment.find(params[:id])
    img.purge
    redirect_back fallback_location: root_path
  end

  private
    def album_params
      params.require(:album).permit(:name, :description, :price, :publish,:all_tags, :cover_image, image: [])
    end
end