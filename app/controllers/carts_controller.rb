class CartsController < ApplicationController
    
    def index
        if current_user.present?
        @carts = Cart.where(user_id: current_user.id)
        else
            redirect_to products_path, notice: 'please log in'
        end  
    end

    def create  
             
        @cart = current_user.carts.new(cart_params)
        if @cart.save
            redirect_to products_path, notice: 'added to cart' 
        else
            cart = Cart.find_by(product_id: params[:product_id])
            pro = Product.find(cart.product_id)  
            cart.update(quantity: (cart.quantity + 1), totalamount: (pro.price * (cart.quantity + 1)))
            redirect_to products_path, notice: 'quantity has been increased' 
        end

    end
    def destroy
        cart = Cart.find(params[:id])
        if cart.destroy
            redirect_to carts_path notice: 'product has been removed'
        
    
        end
    end
    def add
        cart = Cart.find(params[:id])
        pro = Product.find(cart.product_id)  
        cart.quantity += 1
        cart.save
        cart.update( totalamount: (pro.price * cart.quantity ))
        redirect_to carts_path
      end
      def reduce
        cart = Cart.find(params[:id])
        pro = Product.find(cart.product_id)  
        cart.quantity -= 1
        cart.save
        cart.update( totalamount: (pro.price * cart.quantity ))
        redirect_to carts_path
      end
    private
    def cart_params
        params.permit(:product_id, :totalamount )
      end
end