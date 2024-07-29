class Candidate < ApplicationRecord
  belongs_to :user
  has_many :interviews, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness:true, format: { with: /\A\d{10}\z/ }
end
