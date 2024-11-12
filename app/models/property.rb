class Property < ApplicationRecord
  monetize :price_cents, allow_nil: true
  has_many_attached :images
  has_many :reviews, dependent: :destroy

  def update_average_overall
    average_overall = reviews.average(:overall)
    update_column(:average_overall, average_overall)
  end

end
