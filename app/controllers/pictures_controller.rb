class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:index, :show]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_owns_picture, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def show

  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id

    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures"
      redirect_to '/pictures'
    else
      # otherwise render new.html.erb
      render :new
    end
  end

  def edit
    ensure_user_owns_picture
  end

  def update
    ensure_user_owns_picture
    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to "/pictures/#{ @picture.id }"
    else
      render :edit
    end
  end

  def destroy
    ensure_user_owns_picture
    @picture.destroy
    redirect_to "/pictures"
  end

  private

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user_owns_picture
    if current_user != @picture.user
      flash[:alert] = ["You are not the photo's owner!"]
      redirect_to root_url
    end
  end

end
