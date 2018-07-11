require 'sinatra'
require "sinatra/reloader"

get '/' do 
	@content = "Hello World"
	erb :index
end	