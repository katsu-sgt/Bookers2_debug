class Room < ApplicationRecord
  has_many :user_rooms, dependet: :destroy
  has_many :massages, dependet: :destroy
end
