# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    Rails.logger.info "Liking article #{like_params[:article_id]}"
    @like = Like.find_or_create_by(like_params)

    respond_to do |format|
      if @like.save
        format.html { render partial: 'articles/like_status',
                      locals: { article_id: @like.article_id,
                                liked: true} }
      else
        Rails.logger.warn "Could not like article #{like_params[:article_id]}"
        format.html { head :unprocessable_entity }
      end
    end
  end

  def destroy
    Rails.logger.info "Unliking article #{like_params[:article_id]}"
    @like = Like.where(like_params).first
    @like&.destroy

    respond_to do |format|
      format.html { render partial: 'articles/like_status',
                    locals: { article_id: like_params[:article_id],
                              liked: false} }
    end
  end

  private

  def like_params
    params.permit(:article_id)
  end
end
