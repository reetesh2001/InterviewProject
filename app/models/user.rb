class User < ApplicationRecord
  has_many :candidates
  has_many :interviews
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true,uniqueness:true, format: { with: /\A\d{10}\z/ }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
