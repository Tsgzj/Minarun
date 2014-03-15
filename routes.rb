# !/usr/bin/env ruby
# --
# routes.rb --- 
#
# Copyright (C) 2013  Sun Wenxiang<Tsgzj>
# Create: Tue Mar  4 11:16:29 2014
#
# Author: Sun Wenxiang <wxsun1991@gmail.com>
# Organization: Nanjing University
#
#
# routes
get '/' do
  @entries = Entry.all
  slim :index
end

get '/dup' do
  @dup = Duplicate
  slim :dup
end

get '/feeds' do
  @feeds = Feed.all
  slim :feeds
end

post '/feeds' do
  Feed.create params[:feed]
  Feed.last.update(last_modified: DateTime.parse("1999 mar 1"))
  redirect '/feeds'
end

get '/get/:query' do
  @entries = Entry.all(:title.like => "%#{params[:query]}%") | Entry.all(:content.like => "%#{params[:query]}%") 
  slim :index
end

post '/search' do
  redirect "/get/#{params[:query]}"
end

delete '/feeds/:id' do
  #Entry.get(:feed_url => Feed.get(params[:id]).feed_url).destroy
  Feed.get(params[:id]).destroy
  redirect '/feeds'
end

# not_found do
#   "Whoops! You requested a route that wasn't available."
# end
