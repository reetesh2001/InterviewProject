class Candidate < ApplicationRecord
  belongs_to :user
  has_many :interviews, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, format: { with: /\A[A-Za-z\s]+\z/}
  validates :phone, presence: true,uniqueness:true, format: { with: /\A\d{10}\z/ }
  validates :experience, numericality: { greater_than_or_equal_to: 0 }
  validates :college, presence: true, format: { with: /\A[A-Za-z\s]+\z/}
  validates :role, presence: true, format: { with: /\A[A-Za-z\s]+\z/}
  validates :company, presence: true, format: { with: /\A[A-Za-z\s]+\z/}
end
