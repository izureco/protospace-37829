class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: :edit

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
      # redirect_toにすると、newアクションが実行されて、中身が消えてしまう。
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new

    # @prototype.comments : @prototypeへ投稿された全てのcommentを取得できる???
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    else
      render :destroy
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  
  def move_to_index
    if user_signed_in?
      user = User.find(params[:id])
      unless current_user.id == user.id
        redirect_to action: :index
      end
    end
  end

end
