module Tracks
  extend ActiveSupport::Concern

  @agent=Mechanize.new
  # @search=@agent.get("http://www.discogs.com").form(id: "site_search")

  

  class ActiveRecord::Base
    include Tracks 
  end
end