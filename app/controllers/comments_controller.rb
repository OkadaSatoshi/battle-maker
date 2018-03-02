class CommentsController < ApplicationController
  def create
    @battle = Battle.find(params[:battle_id])
    @comment = @battle.comments.build(comment_params)
    @comment.user_id = current_user.id
    
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to battle_path(@battle), notice: '投稿できませんでした' }
      end
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:user_id, :battle_id, :content)
  end
end
