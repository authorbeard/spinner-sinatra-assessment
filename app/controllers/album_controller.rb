class AlbumController < ApplicationController

 

  get "/albums/new" do
    if logged_in
      erb :'albums/new'
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
  end

  post '/albums' do

  end

  get "/all-albums" do
    if logged_in
      @fan=Fan.find(session[:id])
    end
# binding.pry
    @albums=Album.all.sort_by{|a| a.artist_id}
    erb :'albums/all'
  end

  

  get '/albums/:id' do
    @album=Album.find(params[:id])
    erb :'albums/show'
  end

  get '/albums/:id/add' do
# binding.pry
    if logged_in
      current_user.albums << Album.find(params[:id])
# binding.pry
    else 
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end

  end

  get '/albums/:id/edit' do
    if logged_in
      @album=Album.find(params[:id])
      erb :'albums/edit'
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end

  end

  patch '/albums/:id' do
    if logged_in
      album=Album.find(params[:id])
# binding.pry
      
      album.title=params["album_title"]

      if !params["new_artist"].empty?
        album.artist=Artist.find_or_create(name: params["new_artist"])
      elsif params["chg_artist"]
        album.artist=Artist.find(params["chg_artist"])
      else
        album.artist.name=params["artist_name"]
  # binding.pry
      end

      if !params["new_song"].empty?
  # binding.pry
        album.songs<<Song.create(title: params["new_song"])
      elsif params["songs"].size!=album.songs.size
        album.songs=params["songs"].collect{|s| Song.find_or_create_by(id: s)}
      end

      album.save
# binding.pry      
      redirect "/albums/#{album.id}"
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end

  end

  get '/albums/get-songs' do
    "This is where I'll use mechanize"

  end

  get '/albums/:id/spin' do
    if logged_in
      Spin.create(fan_id: current_user.id, album_id: params[:id])
      redirect "albums/#{params[:id]}"
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
# binding.pry
  end


  delete '/albums/:id/delete' do
# binding.pry
    if logged_in
      album=Album.find(params[:id])
      album.delete
      redirect '/collection'
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
    album=Album.find(params[:id])
    album.delete

  end




end