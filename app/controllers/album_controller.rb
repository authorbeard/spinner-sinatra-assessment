class AlbumController < ApplicationController

  get "/albums/new" do
    if logged_in
      erb :'albums/new'
    else
      erb :'users/.login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
  end
end