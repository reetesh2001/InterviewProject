class User < ApplicationRecord
  has_many :candidates
  has_many :interviews
  has_many_attached :files
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
