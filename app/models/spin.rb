class Spin < ActiveRecord::Base

  belongs_to :fan
  belongs_to :album
  has_many :artists, through: :albums

end