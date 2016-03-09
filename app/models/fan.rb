class Fan < ActiveRecord::Base

  has_secure_password
  
  has_many :fan_albums
  has_many :albums, through: :fan_albums
  has_many :spins

end