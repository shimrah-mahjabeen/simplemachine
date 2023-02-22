class Api::V1::OrdersController < Api::V1::ApiController
  before_action :set_order, only: %i[show update]
  before_action :authorize_order, only: %i[show update]

  def index
    @pagy, @orders = pagy(policy_scope(Order))
  end

  def show
    @order = policy_scope(Order).find_by_hashid!(params[:id])
  end

  def update
    if @order.update(order_params)
      render :show
    else
      render_attributes_errors(@order)
    end
  end

  private

  def authorize_order
    authorize @order
  end

  def order_params
    params.require(:order).permit(:status)
  end

  def set_order
    @order = policy_scope(Order).find_by_hashid!(params[:id])
  end
end
