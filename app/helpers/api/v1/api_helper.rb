module Api
  module V1
    module ApiHelper
      include Pagy::Frontend

      def next_page_url(pagy)
        return unless pagy.next

        pagy_url_for(pagy, pagy.next, absolute: true)
      end

      def prev_page_url(pagy)
        return unless pagy.prev

        pagy_url_for(pagy, pagy.prev, absolute: true)
      end
    end
  end
end
