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
binding.pry
    @albums=Album.all.sort_by{|a| a.artist_id}
    erb :'albums/all'
  end

  

  get '/albums/:id' do

  end

  get '/albums/:id/add' do
binding.pry
    if logged_in
      current_user.albums << Album.find(params[:id])
binding.pry
    else 
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end

  end

  get '/albums/:id/edit' do
    if logged_in
      erb :'albums/new'
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end

  end

  patch '/albums/:id' do
    if logged_in
      erb :'albums/new'
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end

  end

  get '/album/:id/spin' do
    if logged_in
      Spin.create(fan_id: current_user.id, album_id: params[:id])
      redirect "albums/#{params[:id]}"
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
binding.pry
  end


  delete '/albums/:id' do
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