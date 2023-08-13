class Group < ApplicationRecord
  has_many :groupings, dependent: :destroy
  has_many :users, through: :groupings, source: :user
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
end
