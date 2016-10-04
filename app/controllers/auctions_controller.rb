class AuctionsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :update, :destroy]

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new params.require(:auction).permit(:title,
                                                          :description,
                                                          :end_date,
                                                          :reserve_price)

    @auction.user = current_user
    if @auction.save
    redirect_to auction_path(@auction), notice: "Auction created"
    else
    render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
    @bid = Bid.new
  end

  def index
    @auctions = Auction.order(created_at: :desc)
  end

  def index_all
  end

  def destroy
    auction = Auction.find params[:id]
    auction.destroy
    redirect_to auctions_path, notice: "Auction deleted"
  end

end
