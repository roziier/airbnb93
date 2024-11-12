# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

5.times do |i|
  User.create({
    email: "test#{i+1}@test.com",
    password: "password"
  })
end

6.times do |i|
  property = Property.create!({
    name: Faker::Lorem.word,
    headline: Faker::Lorem.sentences(number: 1),
    description: Faker::Lorem.paragraphs,
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    price: Money.from_amount((50..200).to_a.sample, 'EUR')
  })

  property.images.attach(
    io: File.open("db/images/property_#{i+1}.png"),
    filename: 'file.png'
  )
  property.images.attach(
    io: File.open("db/images/property_#{i+7}.png"),
    filename: 'file.png'
  )

  5.times do |i|
    review = Review.create!({
      content: "Review number #{1+i}",
      cleanliness: Faker::Number.between(from: 1, to: 5),
      accuracy: Faker::Number.between(from: 1, to: 5),
      checkin: Faker::Number.between(from: 1, to: 5),
      communication: Faker::Number.between(from: 1, to: 5),
      location: Faker::Number.between(from: 1, to: 5),
      value: Faker::Number.between(from: 1, to: 5),
      property: property,
      user: User.all.sample
    })
  end

end