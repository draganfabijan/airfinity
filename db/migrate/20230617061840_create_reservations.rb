class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.belongs_to :guest
      t.string :code
      t.date :start_date
      t.date :end_date
      t.string :status
      t.integer :nights
      t.decimal :payout_price, precision: 10, scale: 2
      t.decimal :security_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2
      t.string :currency
      t.integer :total_number_of_guests
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_infants

      t.timestamps
    end
    add_index :reservations, :code, unique: true
  end
end
