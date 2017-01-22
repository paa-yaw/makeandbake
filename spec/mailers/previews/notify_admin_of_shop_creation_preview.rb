# Preview all emails at http://localhost:3000/rails/mailers/notify_admin_of_shop_creation
class NotifyAdminOfShopCreationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notify_admin_of_shop_creation/admin_notification
  def admin_notification
    NotifyAdminOfShopCreation.admin_notification
  end

end
