require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  describe "#new" do

    context "with no signed in user" do
      it "redirects to root path" do
        post :create
        expect(response).to redirect_to root_path
      end
    end

    context "with signed in user" do
      before { request.session[:user_id] = user.id }

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "instantiates a new auction instance variable" do
      get :new
      expect(assigns(:auction)).to be_a_new(Auction)
      end
    end

  end

  describe "#create" do
    context "with no signed in user" do
      it "redirects to root path" do
        post :create
        expect(response).to redirect_to root_path
      end
    end

    context "with signed in user" do
      before { request.session[:user_id] = user.id }

      context "with valid parameters" do
        def valid_request
          post :create, params: {auction: {title: "auction title",
                                            description: "hello",
                                            reserve_price: 100,
                                            end_date: Time.now + 30.days}}
        end

        it "saves a record to the database" do
          count_before = Auction.count
          valid_request
          count_after = Auction.count
          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the auction show page" do
          valid_request
          expect(response).to redirect_to(auction_path(Auction.last))
        end

        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid parameters" do
        def invalid_request
          post :create, params: {auction:{title: ""}}
        end

        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end

        it "doesn't save the record to the database" do
          count_before = Auction.count
          invalid_request
          count_after = Auction.count
          expect(count_after).to eq(count_before)
        end
      end
    end
  end
end
