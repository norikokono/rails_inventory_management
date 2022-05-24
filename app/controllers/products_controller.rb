class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_product!, except: [:create]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

    def index
      @products = Product.all.order(created_at: :DESC)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new product_params
      @product.user = @current_user
      if @product.save
        redirect_to @product, notice: "Created New Product!"
      else
        render :new
      end
    end

    def show
      @product = Product.find(params[:id])
      @review = Review.new
    end

    def edit
      @product = Product.find(params[:id])
    end

    def update
      @product = Product.find params[:id]
      if @product.update product_params
        redirect_to product_path(@product), notice: "Product edited successfully."
      else
        render :edit
      end
    end


    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      flash[:success] = "Product deleted successfully."
      redirect_to products_url
    end
    
      #redirect_to products_path, notice: "Product deleted successfully."

    private

    def product_params
      params.require(:product).permit(:title, :description)
    end

    def load_product!
      if params[:id].present?
        @product = Product.find (params[:id])
      else
        @product = Product.new
      end
    end

    def authorize_user!
      unless can? :crud, @product
        flash[:danger] = "Access Denied"
        redirect_to root_path
    end
  end
end