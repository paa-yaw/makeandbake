class SellerNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(order, seller)
    @order = order
    @seller = seller
    NotifySeller.seller_notification(@order, @seller).deliver_later
  end
end
