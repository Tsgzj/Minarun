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
  @entries = Entry
  slim :index
end

get '/feeds' do
  @feeds = Feed.all
  slim :feeds
end

post '/feeds' do
  Feed.create params[:feed]
  redirect '/feeds'
end

get '/get/:query' do
  @entries = Entry.full_text_search("#{params[:query]}")
  slim :index
end

post '/search' do
  redirect "/get/#{params[:query]}"
end

delete '/feeds/:id' do
  Entry.get(:feed_url => Feed.get(params[:id]).feed_url).destroy
  Feed.get(params[:id]).destroy
  redirect '/feeds'
end

get '/duplicate' do
  @dup = Duplicate
  slim :dup
end


# not_found do
#   "Whoops! You requested a route that wasn't available."
# end
