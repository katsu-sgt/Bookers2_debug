class Group < ApplicationRecord
  has_many :group_users
  
  validates :name, presence: true
end
