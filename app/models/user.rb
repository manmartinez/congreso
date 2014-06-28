class User < ActiveRecord::Base

  validates :email, :full_name, presence: true
  validates :email, uniqueness: true
end
