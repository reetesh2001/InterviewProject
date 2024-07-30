class Candidate < ApplicationRecord
  belongs_to :user
  has_many :interviews, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true,uniqueness:true, format: { with: /\A\d{10}\z/ }
  validates :experience, numericality: { greater_than_or_equal_to: 0 }
end
