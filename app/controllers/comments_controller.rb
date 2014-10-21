class CommentsController < ApplicationController
  def create
    card    = Card.find(params[:card_id])
    comment = card.post_comment(
      by: current_user,
      with: params.require(:comment).permit(:text)
    )

    if comment.valid?
      CommentMailer.new_comment(comment).deliver
    else
      flash[:alert] = t("comments.create.error")
    end

    redirect_to [card.board, card]
  end
end
