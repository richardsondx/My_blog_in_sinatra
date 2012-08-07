require 'sinatra'

get '/' do
  @posts = Post.ordered
  @next_page = next_page
  erb :index
end