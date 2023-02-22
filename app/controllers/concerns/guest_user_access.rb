module GuestUserAccess
  extend ActiveSupport::Concern

  included do
    skip_before_action :authenticate_user!, only: %i[index show]
  end
end
