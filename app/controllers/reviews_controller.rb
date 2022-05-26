class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_review!, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def create
    @product = Product.find params[:product_id]
    @review = Review.new params.require(:review).permit(:body)
    @review.product = @product
    @review.user = @current_user
    
    if @review.save
      redirect_to product_path(@product), notice: "Review created successfully."
    else
      render 'products/show'
    end
  end
  
  def destroy
    if @review.destroy
    redirect_to product_path(@review.product), notice: "Review deleted successfully."
    else
      render 'destroy', status: :unprocessable_entity
    end
end

  private

  def load_review!
    if params[:id].present?
      @review = Review.find params[:id]
    else
      @review = Review.new
    end
  end

  def authorize_user!
    unless can? :crud, @review
      flash[:danger] = "Acess Denied"
      redirect_to root_path
    end
  end
end