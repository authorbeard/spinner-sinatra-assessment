class AlbumController < ApplicationController

 
  get "/all-albums" do
    if logged_in
      @fan=Fan.find(session[:id])
    end
    @albums=Album.all.sort_by{|a| a.artist}
    erb :'albums/all'
  end
  
  get '/get-tracks/:id' do
    @album=Album.find(params[:id])
    @album.get_tracks
    redirect "albums/#{@album.id}"
  end

  get "/albums/new" do
    if logged_in
      erb :'albums/new'
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
  end

  post '/albums' do

    if params["alb_title"].empty? 
      redirect "/albums/new"
    else
      album=Album.create(title: params["alb_title"])
      
      if params["alb_artist"]
        album.artist = Artist.find(params["alb_artist"])
      else
        album.artist=Artist.find_or_create_by(name: params["new_artist"])
      end

      album.rel_date=params["rel_date"]
      album.alb_url=params["alb_url"]

      if logged_in 
        album.fans << Fan.find(session[:id])
      end
       album.save
       redirect "/albums/#{album.id}"
    end 
  end


  get '/albums/:id' do
    @album=Album.find(params[:id])
    erb :'albums/show'
  end

  get '/albums/:id/add' do
    if logged_in
      current_user.albums << Album.find(params[:id])
      redirect "/all-albums"
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
      
      album.title=params["album_title"]

      if !params["new_artist"].empty?
        album.artist=Artist.find_or_create(name: params["new_artist"])
      elsif params["chg_artist"]
        album.artist=Artist.find(params["chg_artist"])
      else
        album.artist.name=params["artist_name"]
      end

      if !params["new_song"].empty?
        album.songs<<Song.create(title: params["new_song"])
      elsif params["songs"].size!=album.songs.size
        album.songs=params["songs"].collect{|s| Song.find_or_create_by(id: s)}
      end
      album.save      
      redirect "/albums/#{album.id}"
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
  end



  get '/albums/:id/spin' do
    if logged_in
      Spin.create(fan_id: current_user.id, album_id: params[:id])
      redirect "albums/#{params[:id]}"
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
  end


  delete '/albums/:id/delete' do
    if logged_in
      album=Album.find(params[:id])
      album.delete
      redirect '/collection'
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end

  end


end