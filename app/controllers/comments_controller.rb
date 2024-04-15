class CommentsController < ApplicationController
  #before_action :set_feature, only: %i[new, create]

  def new
    @feature = Feature.find(params[:feature_id])
    @comment = Comment.new
  end

  def create
    @feature = Feature.find(params[:feature_id])
    @comment = Comment.new(comment_params)
    @comment.feature = @feature

    if @comment.save
      redirect_to feature_path(@comment.feature_id, anchor: "feature")
    else
      render :new
    end
  end

  private

  def set_feature
    @feature = Feature.find(params[:feature_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
