class Api::V1::FoodItemsController < Api::V1::ApiController
  include GuestUserAccess

  before_action :set_food_item, only: %i[show update destroy]
  before_action :authorize_food_item, only: %i[show update destroy]

  def index
    @pagy, @food_items = pagy(policy_scope(FoodItem))
  end

  def create
    authorize FoodItem

    @food_item = current_shop.food_items.build(food_item_params)
    if @food_item.save
      render :show
    else
      render_attributes_errors(@food_item.errors)
    end
  end

  def update
    if @food_item.update(food_item_params)
      render :show
    else
      render_attributes_errors(@food_item.errors)
    end
  end

  def destroy
    @food_item.destroy

    head :no_content
  end

  private

  def authorize_food_item
    authorize @food_item
  end

  def food_item_params
    params.require(:food_item).permit(:name, :desc, :price, :is_available, :category, :tax)
  end

  def set_food_item
    @food_item = policy_scope(FoodItem).find_by_hashid!(params[:id])
  end
end
