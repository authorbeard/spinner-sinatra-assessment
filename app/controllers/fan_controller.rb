class FanController < ApplicationController


  get '/login' do
    if logged_in
      redirect '/home'
    else
      erb :'fans/login'
    end
  end

  post '/login' do
    fan = Fan.find_by(name: params["name"])
    if fan && fan.authenticate(params["password"])
      session[:id] = fan.id
      redirect '/home'
    else
      erb :'/index', :locals=>{:message=>"Nope. Try again or sign up."}
    end
  end

  get '/signup' do
    if logged_in
      redirect to '/home'
    end
    erb :'/fans/signup'
  end

  post '/signup' do
    if logged_in
      redirect '/home'
    elsif params.values.include?('')
      erb :'fans/signup', :locals=>{:message=>"Whoops, you missed something. Try again." }
    else
      fan = Fan.new(params)
      if fan.save
        session[:id] = fan.id
        redirect "fans/#{fan.id}/collection"
      end
    end
    
  end

  get '/home' do
    if logged_in
      erb :'fans/home'
    else
      redirect '/'
    end
  end  

  get '/collection' do
    if logged_in
      redirect "/fans/#{current_user.id}/collection"
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
  end

  get '/fans/:id/collection' do
    if logged_in
      erb :'fans/home'
    else
      erb :'fans/login', :locals=>{:message=>"You gotta be logged for that, bub."}
    end
  end


  get '/logout' do
    session.clear
    redirect '/'
  end



end
