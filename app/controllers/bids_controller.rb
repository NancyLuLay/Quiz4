class BidsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :update, :destroy]

  def create
    @bid = Bid.new params.require(:bid).permit(:amount)
    @auction = Auction.find params[:auction_id]
    @bid.auction = @auction
    @bid.user = current_user
    @bid.save
    redirect_to auction_path(@auction), notice: "Bid created"
  end

  def destroy
    bid = Bid.find params[:id]
    bid.destroy
  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
