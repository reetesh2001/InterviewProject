class User < ApplicationRecord
  has_many :candidates
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
