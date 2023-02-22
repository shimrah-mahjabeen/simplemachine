# frozen_string_literal: true

module Api
  module V1
    module Admin
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        include ActAsApiRequest
        include ExceptionHandler

        private

        def sign_up_params
          params
            .require(:user)
            .permit(:email, :password, :first_name, :last_name, :locale)
            .merge(role: :admin)
            .merge(shop_attributes: shop_params)
        end

        def shop_params
          params.require(:shop).permit(:shop_name)
        end

        def render_create_success
          render :create
        end

        def render_create_error
          raise ActiveRecord::RecordInvalid, @resource
        end

        def validate_post_data(which, message)
          render_errors(message, :bad_request) if which.empty?
        end
      end
    end
  end
end
