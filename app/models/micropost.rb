class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites , dependent: :destroy
  has_many :liking_users, through: :favorites, source: :user
 
end