class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.for_shop_user(user.id)
      else
        scope.where(user: user)
      end
    end
  end

  def index?
    true
  end

  def show?
    index?
  end

  def update?
    return false unless user.admin?

    user.shop == record.shop
  end
end
