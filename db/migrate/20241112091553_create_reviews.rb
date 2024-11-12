class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :cleanliness
      t.integer :accuracy
      t.integer :checkin
      t.integer :communication
      t.integer :location
      t.integer :value
      t.decimal :overall
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end