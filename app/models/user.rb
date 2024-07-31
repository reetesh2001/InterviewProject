class User < ApplicationRecord
  has_many :candidates
  has_many :interviews
  validates :name, presence: true, format: { with: /\A[A-Za-z\s]+\z/, message: "only allows letters and spaces" }
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true,uniqueness:true, format: { with: /\A\d{10}\z/ }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
