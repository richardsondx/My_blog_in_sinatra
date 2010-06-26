require 'rubygems'
require 'sinatra'
require 'config'

before do
  @widgets = Widget.all
end

get '/' do
  @posts = Post.ordered
  erb :index
end

get '/search' do
  @posts = Post.search params[:q]
  erb :index
end

get '/feed' do
  @posts = Post.ordered
  erb :feed, :layout => false
end

get '/login' do
  erb :login
end

post '/login' do
  if auth? params[:code]
    login
    go_home
  else
    message 'Ops! Wrong code.'
    erb :login
  end
end

get '/logout' do
  if_logged do
    login false
    go_home
  end
end

get '/post/new' do
  if_logged do
    @post = Post.new
    erb :post
  end
end

post '/post' do
  if_logged do
    post = Post[params[:id]] || Post.new
    post.title = params[:title]
    post.text = params[:text]
    post.date = Time.now unless post.id
    post.save
    go_home
  end
end

get '/post/:id' do
  if_logged do
    @post = Post[params[:id]]
    erb :post
  end
end

delete '/post/:id' do
  if_logged do
    Post[params[:id]].delete
    go_home
  end
end

get '/widget/new' do
  if_logged do
    @widget = Widget.new
    erb :widget
  end
end

post '/widget' do
  if_logged do
    widget = Widget[params[:id]] || Widget.new
    widget.title = params[:title]
    widget.content = params[:content]
    widget.save
    go_home
  end
end

get '/widget/:id' do
  if_logged do
    @widget = Widget[params[:id]]
    erb :widget
  end
end

delete '/widget/:id' do
  if_logged do
    Widget[params[:id]].delete
    go_home
  end
end

get '/settings' do
  if_logged do
    erb :settings
  end
end

post '/settings' do
  if_logged do
    if auth? params[:code]
      $blog.name = params[:name]
      $blog.title = params[:title]
      $blog.code = params[:new_code] unless params[:new_code].empty?
      $blog.save
      go_home
    else
      message 'Ops! Wrong code.'
      erb :settings
    end
  end
end