class FoodItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    index?
  end

  def create?
    user.admin?
  end

  def update?
    create? && record.shop.user == user
  end

  def destroy?
    update?
  end
end
