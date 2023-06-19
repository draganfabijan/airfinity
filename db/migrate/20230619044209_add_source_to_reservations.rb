class AddSourceToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :source, :string
  end
end
