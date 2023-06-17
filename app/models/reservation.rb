class Reservation < ApplicationRecord

  # Associations
  belongs_to :guest

  # Validations
  validates :code, presence: true, uniqueness: true
  validates :start_date, :end_date, presence: true

end
