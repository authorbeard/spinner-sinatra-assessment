class FanAlbum < ActiveRecord::Base

  belongs_to :fan
  belongs_to :album

end