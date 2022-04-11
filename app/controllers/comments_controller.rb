class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
      # コメント格納用のインスタンスを生成
    if @comment.save
      # もしvaridation(contentが空じゃない)を通過したなら、コメントに紐づくshowページに遷移
      redirect_to prototype_path(@comment.prototype.id)
    else
      # もしvaridationに引っ掛かったら、showページに戻す。
      @prototype = @comment.prototype
      @comments = @prototype.comments
        # renderする前に、show.htmlで使用する@prototypeと@commentに値を入れておく
        # redirect_toと同じ処理のような気がする...
      render "prototypes/show" # views/tweets/show.html.erbのファイルを参照しています。
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end