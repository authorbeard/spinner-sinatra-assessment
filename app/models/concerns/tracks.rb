module Tracks
  extend ActiveSupport::Concern

  
  def get_tracks
    @agent=Mechanize.new
    @search=@agent.get("http://www.discogs.com").form(id: "site_search")
    @search.q=self.search_q
    results=@agent.submit(@search)
    alb_url=results.css("div.card a")[0]["href"]
    alb_pg=agent.get(alb_url)
    t_names=alb_pg.css("tr.track").css("span.tracklist_track_title").collect{|t| t.text}
    t_names.each {|t| self.songs << Song.find_or_create_by(title: "t")}
  end
  

  class ActiveRecord::Base
    include Tracks 
  end
end