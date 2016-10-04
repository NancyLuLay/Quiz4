require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
    it "requires an email" do
      attributes = FactoryGirl.attributes_for(:user)
      attributes[:email] = nil
      user = User.new attributes
      user.valid?
      expect(user.errors).to have_key(:email)
    end

    it "requires a unique email" do
      user = FactoryGirl.create(:user)
      attributes = FactoryGirl.attributes_for :user
      attributes[:email] = user.email
      user1 = User.new attributes
      user1.valid?
      expect(user1.errors).to have_key :email
    end

    it "requires a first name" do
      attributes = FactoryGirl.attributes_for :user
      attributes[:first_name] = nil
      user = User.new attributes
      user.valid?
      expect(user.errors).to have_key(:first_name)
    end
  end
end
