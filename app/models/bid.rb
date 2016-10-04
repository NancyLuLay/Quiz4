class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :auction

  validates :amount, presence: true, numericality: {greater_than: 0}

end
