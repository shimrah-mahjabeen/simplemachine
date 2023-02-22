class OrderMailer < ApplicationMailer
  def prepared
    @order = params[:order]

    mail(to: @order.user.email, subject: 'Your Order has been prepared')
  end
end
