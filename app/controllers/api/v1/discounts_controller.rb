class Api::V1::DiscountsController < Api::V1::ApiController
  include GuestUserAccess

  before_action :set_discount, only: %i[show update destroy]
  before_action :authorize_discount, only: %i[show update destroy]

  def index
    @pagy, @discounts = pagy(Discount.where(active: true))
  end

  def show; end

  def create
    authorize Discount
    @discount = Discount.new(discount_params)

    if @discount.save
      render :show
    else
      render_attributes_errors(@discount.errors)
    end
  end

  def update
    if @discount.update(discount_params)
      render :show
    else
      render_attributes_errors(@discount.errors)
    end
  end

  def destroy
    @discount.destroy

    head :no_content
  end

  private

  def authorize_discount
    authorize @discount
  end

  def discount_params
    params
      .require(:discount)
      .permit(:name, :desc, :discount_item, :discounted_with, :discount_percentage)
      .tap do |discount|
      discount[:discount_item_id] = discount_item_id if discount_item_id
      discount[:discounted_with_id] = discounted_with_id if discounted_with_id
    end
  end

  def set_discount
    @discount = Discount.find(params[:id])
  end

  def discount_item_id
    return unless params.dig(:discount, :discount_item_id).present?

    @discount_item_id ||= FoodItem.decode_id(params.dig(:discount, :discount_item_id))
  end

  def discounted_with_id
    return unless params.dig(:discount, :discounted_with_id).present?

    @discounted_with_id ||= FoodItem.decode_id(params.dig(:discount, :discounted_with_id))
  end
end
