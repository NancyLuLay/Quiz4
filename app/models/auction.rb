class Auction < ApplicationRecord
  has_many :bids, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, uniqueness: true

  def titleized_title
    title.titleize
  end

end
