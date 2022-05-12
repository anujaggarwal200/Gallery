class HomeController < ApplicationController
	def index
    if user_signed_in?
      # @published_albums = Album.where(publish: true)
      # @unpublished_albums = Album.where(publish: false)
      @q = Album.where(publish: true).ransack(params[:q])
      @q1 = current_user.albums.where(publish: false).ransack(params[:q])
        @published_albums = @q.result
        @unpublished_albums = @q1.result
    else
        #@published_albums = Album.where(publish: true)
        @q = Album.where(publish: true).ransack(params[:q])
        @published_albums = @q.result
    end
  end
end