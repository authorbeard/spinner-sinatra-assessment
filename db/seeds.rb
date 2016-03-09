#!/usr/bin/env/ruby

require 'csv'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

require_relative 'album'
require_relative 'artist'
require_relative 'song'


@agent=Mechanize.new
@search=@agent.get("http://www.discogs.com").form(id: "site_search")

@lib=CSV.read("authorbeard.csv", {headers: true, header_converters: :symbol})


def seed
  @lib.each {|r|
    artist=Artist.find_or_ceate(r[:artist])
    @search.q="#{r[:artist]} #{r[:release_id]}"




  }

end


