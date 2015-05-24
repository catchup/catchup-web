class CommentsController < ApplicationController
  def create
    comment = card.post_comment(
      by: current_user,
      with: comment_params
    )

    if comment.valid?
      CommentMailSender.new_comment(comment, current_user)
    else
      flash[:alert] = t("comments.create.error")
    end

    redirect_to [card.board, card]
  end

  def update
    comment = card.comments.find(params[:id])
    comment.update_attributes(comment_params)

    redirect_to [card.board, card]
  end

  private

  def card
    @card ||= Card.find(params[:card_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
