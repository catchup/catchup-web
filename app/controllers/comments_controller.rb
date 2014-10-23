class CommentsController < ApplicationController
  def create
    card    = Card.find(params[:card_id])
    comment = card.post_comment(
      by: current_user,
      with: comment_params
    )

    if comment.valid?
      CommentMailer.new_comment(comment, comment.involved_users).deliver
    else
      flash[:alert] = t("comments.create.error")
    end

    redirect_to [card.board, card]
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
