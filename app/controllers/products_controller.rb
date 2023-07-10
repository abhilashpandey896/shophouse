class ProductsController < ApplicationController
  
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, :except => [:index, :show, :search_user ]
  # GET /products or /products.json
  def index
    
    if current_user && current_user.admin?
      @products = Product.where(user_id: current_user.id).paginate(page: params[:page], per_page: 2)
    else
      @products = Product.all.paginate(page: params[:page], per_page: 2)
      
    end

  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.all
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.new(product_params)
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def search_user 
    @get_user = Product.where("name LIKE ? AND brand LIKE ?","#{params[:name]}%", "#{params[:brand]}%" )
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :title, :brand, :price, :image, )
    end
end
