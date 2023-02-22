module Api
  module V1
    class ApiController < ActionController::API
      include ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken
      include ExceptionHandler
      include Pagy::Backend
      include Pundit::Authorization

      before_action :authenticate_user!

      def current_cart
        @current_cart ||= current_user.carts.find_or_create_by(shop: current_shop)
      end

      def current_shop
        @current_shop ||= current_user&.admin? ? current_user.shop : current_shop_by_id
      end

      def current_shop_by_id
        return if params[:shop_id].blank?

        Shop.find_by_hashid!(params[:shop_id])
      end
    end
  end
end
