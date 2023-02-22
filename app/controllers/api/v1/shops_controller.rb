class Api::V1::ShopsController < Api::V1::ApiController
  include GuestUserAccess

  skip_before_action :authenticate_user!, only: %i[food_items discounts]

  before_action :set_shop, only: %i[show update]

  def index
    @pagy, @shops = pagy(Shop.all)
  end

  def show; end

  def update
    authorize @shop

    if @shop.update(shop_params)
      render :show
    else
      render_attributes_errors(@shop)
    end
  end

  def food_items
    @pagy, @food_items = pagy(current_shop.food_items)

    render 'api/v1/food_items/index'
  end

  def orders
    @pagy, @orders = pagy(policy_scope(Order).where(shop: current_shop))

    render 'api/v1/orders/index'
  end

  def discounts
    @pagy, @discounts = pagy(current_shop.discounts.where(active: true))

    render 'api/v1/discounts/index'
  end

  private

  def set_shop
    @shop = Shop.find_by_hashid!(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:shop_name)
  end
end
