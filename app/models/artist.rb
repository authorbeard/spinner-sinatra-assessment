class Artist < ActiveRecord::Base

  has_many :albums
  has_many :songs, through: :albums
  has_many :fans, through: :albums
  has_many :spins, through: :albums

end