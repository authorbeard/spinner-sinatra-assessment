class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end


  helpers do
    def logged_in
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end
end