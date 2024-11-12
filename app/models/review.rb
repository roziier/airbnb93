class Review < ApplicationRecord
  belongs_to :user
  belongs_to :property, counter_cache: true

  validates :content, presence: :true
  validates :cleanliness, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :accuracy, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :checkin, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :communication, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :location, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :value, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}

  after_commit :update_overall, on: [:create, :update]

  def update_overall
    total_score = cleanliness + accuracy + checkin + communication + location + value

    update_column(:overall, total_score.to_f / 6)
    property.update_average_overall
  end
  
end
