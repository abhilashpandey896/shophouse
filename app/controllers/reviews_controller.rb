class ReviewsController < ApplicationController
    load_resource :product, except: :index
    
    def index
        @product = Product.find(params[:product_id])
        @reviews = @product.reviews.all
    end
    def new
        @product = Product.find(params[:product_id])
        @review = @product.reviews.new
    end
    def create
        @review = @product.reviews.new(review_params)
        if @review.save
            redirect_to product_url(@product), notice: 'review has been submitted'
        else
            render :new
        end
    end
    def edit
        @product = Product.find(params[:product_id])
        @review = @product.reviews.find(params[:id])
    end
    def update
        @review = @product.reviews.find(params[:id])
        if @review.update(review_params)
            redirect_to product_url(@product), notice: 'review has been submitted'
        else
            render :edit
        end
    end

 def destroy
        @review = @product.reviews.find(params[:id])
        if @review.destroy
            redirect_to product_url(@product), notice: 'review has been deleted'
        else
            render :edit
        end
    end
    private 
    def review_params
        params.require(:review).permit(:description, :user_id, :product_id)
    end

end