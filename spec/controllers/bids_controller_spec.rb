require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:auction) { FactoryGirl.create :auction }
  let(:bid) {FactoryGirl.create :bid}

  let(:user) { FactoryGirl.create :user }

  describe "#create" do
    context "with no signed in user" do
      it "redirects to root path" do
        post :create, params: { amount: 10, auction_id: auction.id}
        expect(response).to redirect_to root_path
      end
    end

    context "with signed in user" do
      before { request.session[:user_id] = user.id }

      context "with valid attributes" do
        def valid_request
          post :create, params: { bid:      { amount: 20 },
                                  auction_id: auction.id }
        end

        it "creates a bid in the database" do
          count_before = Bid.count
          valid_request
          count_after = Bid.count
          expect(count_after).to eq(count_before + 1)
        end

        it "redirect to the auction show page" do
          valid_request
          expect(response).to redirect_to(auction_path(auction))
        end

        it "associates the created bid with the logged in user" do
          valid_request
          expect(Bid.last.user).to eq(user)
        end

        it "associates the created bid with the auction" do
          valid_request
          expect(Bid.last.auction).to eq(auction)
        end
      end

      context "with invalid attributes" do
        def invalid_request
          post :create, params: {bid: {amount: nil},
                                  auction_id: auction.id
                                }
        end
        it "doesn't create bid in the database" do
          count_before = Bid.count
          invalid_request
          count_after = Bid.count
          expect(count_before). to eq(count_after)
        end
        it "renders the auction show template" do
          invalid_request
          expect(response).to redirect_to("/auctions/#{auction.id}")
        end
      end
    end
  end

  describe "#destroy" do
    context "with no signed in user" do
      it "redirects to root path" do
        delete :destroy, params: {id: bid.id,
                                  auction_id: bid.auction_id}
        expect(response).to redirect_to root_path
      end

    context "with signed in user" do
      before { request.session[:user_id] = user.id }

      it "removes the bid record from the database" do
        bid
        count_before = Bid.count
        delete :destroy, params: { id: bid.id, auction_id: bid.auction.id }
        count_after = Bid.count
        expect(count_after).to eq(count_before - 1)
      end

    end
    end
  end
end
