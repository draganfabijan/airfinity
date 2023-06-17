class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code
      t.date :start_date
      t.date :end_date
      t.string :status
      t.integer :nights
      t.decimal :payout_price
      t.decimal :security_price
      t.decimal :total_price
      t.string :currency
      t.string :total_number_of_guests
      t.string :number_of_adults
      t.string :number_of_children
      t.string :number_of_infants

      t.timestamps
    end
    add_index :reservations, :code, unique: true
  end
end
