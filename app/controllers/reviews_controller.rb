# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    review_form = ReviewForm.new(review_params)
    if review_form.save(current_user)
      flash[:success] = I18n.t('review.success')
    else
      flash[:danger] = review_form.errors.full_messages.to_sentence
    end
    redirect_to book_url(id: review_params[:book_id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :book_rate, :body, :book_id).merge(user: current_user)
  end
end
