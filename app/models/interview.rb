class Interview < ApplicationRecord
  belongs_to :user
  belongs_to :candidate
end
