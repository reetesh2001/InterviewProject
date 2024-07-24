class User < ApplicationRecord
  has_many :candidates
  has_many :interviews
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
