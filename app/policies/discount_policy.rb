class DiscountPolicy < ApplicationPolicy
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
    user.admin? && record.shop.user
  end

  def destroy?
    update?
  end
end
