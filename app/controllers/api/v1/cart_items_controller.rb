module Api
  module V1
    class CartItemsController < Api::V1::ApiController
      before_action :authorize_cart
      before_action :set_cart_item, only: %i[update destroy]
    
      helper_method :bill_calculator
    
      def index
        @pagy, @cart_items = pagy(current_cart.line_items.includes(:food_item))
      end
    
      def create
        @cart_item = current_cart.line_items.build(line_item_params)
    
        if @cart_item.save
          render :show
        else
          render_attributes_errors(@cart_item.errors)
        end
      end
    
      def update
        if @cart_item.update(line_item_params.except(:food_item_id))
          render json: @cart_item
        else
          render_attributes_errors(@cart_item.errors)
        end
      end
    
      def destroy
        @cart_item.destroy
    
        head :no_content
      end
    
      private
    
      def authorize_cart
        authorize :cart
      end
    
      def bill_calculator
        @bill_calculator ||= BillCalculator.new(current_cart)
      end
    
      def line_item_params
        params
          .require(:cart_item)
          .permit(:quantity, :food_item_id)
          .tap do |line_item|
            line_item[:food_item] = food_item if line_item[:food_item_id]
          end
      end
    
      def food_item
        @food_item ||= current_shop.food_items.find_by_hashid!(params.dig(:cart_item, :food_item_id))
      end
    
      def set_cart_item
        @cart_item = current_cart.line_items.find_by_hashid!(params[:id])
      end
    end
  end
end
