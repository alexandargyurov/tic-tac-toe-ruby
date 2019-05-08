require_relative './application'

app = Application.new
app_sessions = Rack::Session::Pool.new(app, :domain => 'localhost', :expire_after => 60 * 5)

run app_sessions