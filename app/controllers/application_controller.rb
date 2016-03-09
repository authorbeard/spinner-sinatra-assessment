class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "butt"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end


  helpers do
    def logged_in
      !!session[:id]
    end

    def current_user
      Fan.find(session[:id])
    end
  end
end