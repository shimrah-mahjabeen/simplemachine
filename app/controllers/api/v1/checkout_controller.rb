module Api
  module V1
    class CheckoutController < ApiController
      before_action :authorize_checkout
      before_action :set_payment

      def create
        FinalizeOrderService.call(current_user, current_cart, @payment)

        if @payment.valid?
          render json: @payment
        else
          render_attributes_errors(@payment.errors)
        end
      end

      private

      def authorize_checkout
        authorize :Checkout
      end

      def set_payment
        @payment = Payment.new(payment_params)
      end

      def payment_params
        params
          .require(:payment)
          .permit(:card, :cvc, :expiry)
          .tap do |payment|
            payment[:user] = current_user
          end
      end
    end
  end
end
