require 'rails_helper'

RSpec.describe Auction, type: :model do
  describe "Validations" do

    it "requires a title" do
      a = Auction.new
      a.valid?
      expect(a.errors).to have_key(:title)
    end

    it "requires a unique title" do
      Auction.create({title: "valid title",
                              description: "auction description",
                              end_date:Time.now + 30.days,
                              reserve_price: 500})
      a = Auction.new title: "valid title"
      a.valid?
      expect(a.errors).to have_key(:title)
    end

  end
end
