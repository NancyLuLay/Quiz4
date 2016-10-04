class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :bid, Auction do |auction|
      user != auction.user
    end

    cannot :bid, Auction do |auction|
      user == auction.user
    end

  end
end
