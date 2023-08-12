class Group < ApplicationRecord
  has_many :groupings, dependent: :destroy
  has_many :users, through: :groupings, source: :user
end
