class CommentsController < ApplicationController
  def create
    card    = Card.find(params[:card_id])
    comment = card.post_comment(
      by: current_user,
      with: params.require(:comment).permit(:text)
    )

    if comment.valid?
      CommentMailSender.new_comment(comment)
    else
      flash[:alert] = t("comments.create.error")
    end

    redirect_to [card.board, card]
  end
end
