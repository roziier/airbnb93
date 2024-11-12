class Property < ApplicationRecord
  monetize :price_cents, allow_nil: true
  has_many_attached :images
  has_many :reviews, dependent: :destroy

  has_many :reservations, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user, dependent: :destroy


  def update_average_overall
    average_overall = reviews.average(:overall)
    update_column(:average_overall, average_overall)
  end

  def available_dates
    next_reservation = reservations.upcoming_reservations.first
    current_reservation = reservations.current_reservations.first

    if current_reservation.nil? && next_reservation.nil?
      Date.tomorrow.strftime('%e %b')..(Date.tomorrow + 30.days).strftime('%e %b')
    elsif current_reservation.nil?
      Date.tomorrow.strftime('%e %b')..next_reservation.checkin_date.strftime('%e %b')
    elsif next_reservation.nil?
      current_reservation.checkout_date.strftime('%e %b')..(Date.tomorrow + 30.days).strftime('%e %b')
    else
      current_reservation.checkout_date.strftime('%e %b')..next_reservation.checkin_date.strftime('%e %b')
    end
  end

end
