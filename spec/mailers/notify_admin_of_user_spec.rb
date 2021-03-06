require "rails_helper"

RSpec.describe NotifyAdminOfUser, type: :mailer do
  describe "notify_admin_of_signup" do
    let(:mail) { NotifyAdminOfUser.notify_admin_of_signup }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify admin of signup")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
