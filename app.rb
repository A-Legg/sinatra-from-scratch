require "sinatra"
require "rack-flash"
require "gschool_database_connection"


class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    erb :register
  end

  post "/register" do
    @database_connection.sql("INSERT INTO email (email) VALUES ('#{params[:email]}')")
    flash[:notice] = "Thank you for registering young padawan"
    redirect "/"

  end


end
