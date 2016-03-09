

require 'csv'
require 'nokogiri'
require 'open-uri'
require 'mechanize'




@lib=CSV.read("test/authorbeard.csv", {headers: true, header_converters: :symbol})


def seed
  @lib.each {|r|
    album=Album.find_or_create_by(title: r[:title])
    album.artist=Artist.find_or_create_by(name: r[:artist])
    album.rel_date=r[:released].to_i
    album.rel_id=r[:release_id].to_i
    album.search_q="#{r[:artist]} #{r[:release_id]}"
    album.save

  }

end


