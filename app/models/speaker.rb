class Speaker < ActiveRecord::Base

  validates :salutation, :company, :name, :bio, presence: true
  validates :salutation, length: { maximum: 10 }
  validates :company, length: { maximum: 100 }
  validates :name, length: { maximum: 100 }

  mount_uploader :photo, PhotoUploader

  has_many :activities  
end
