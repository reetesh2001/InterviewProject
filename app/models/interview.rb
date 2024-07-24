class Interview < ApplicationRecord
  belongs_to :user
  has_one :candidate
end
