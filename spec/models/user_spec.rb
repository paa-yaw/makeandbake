require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build :user }

  subject { @user }

  @user_attributes = [:email, :password, :password_confirmation, :first_name, :last_name, :username, :fullname, :age, :gender, :admin, :seller]

  it { should be_valid }

  #response to user attributes
  @user_attributes.each do |attribute|
  	it { should respond_to attribute }
  end


  # validation specs
  @validated_attributes = [:email, :gender, :age, :username ]

  @validated_attributes.each do |attribute|
    it { should validate_presence_of attribute }
  end

  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_uniqueness_of(:username) }
  it { should validate_confirmation_of :password  }

  # test association

  it { should have_many(:products) }

  describe "test association" do
    before do 
      @user = FactoryGirl.create :user, admin: false, seller: true
      products = 5.times { FactoryGirl.create :product, user: @user }
    end

    it "raise error for dependent destroy" do 
      products = @user.products

      @user.destroy

      products.each do |product|
        expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
