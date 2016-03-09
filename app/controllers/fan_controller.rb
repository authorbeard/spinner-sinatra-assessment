class FanController < ApplicationController


  get '/login' do
    erb :'fans/login'
  end

  post '/login' do
    fan = Fan.find_by(name: params["name"])
    if fan && fan.authenticate(params["password"])
      session[:id] = fan.id
      redirect '/home'
    else
      erb :'/fans/login', :locals=>{:message=>"Nope. Try again or sign up."}
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
        redirect '/home'
      end
    end
    
  end

  get '/home' do
    if logged_in
      erb :home
    else
      redirect '/login'
    end
  end  



end
