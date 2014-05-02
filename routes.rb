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
require 'feedzirra'
get '/' do
  @entries = Entry.order_by(:published.desc)
  slim :index
end

get '/entry' do
  redirect '/'
end


get '/feeds' do
  @feeds = Feed.all
  slim :feeds
end

post '/feeds' do
  f_url = params[:feed]["feed_url"]
  get = true
  feed = Feedzirra::Feed.fetch_and_parse(f_url,
         :on_failure =>
         lambda{|feed, f_url| get = false})
  if get
    Feed.create(title: feed.title, feed_url: f_url)
  end
  redirect '/feeds'
end

get '/entry/:query' do
  @entries = Entry.full_text_search("#{params[:query]}")
  slim :index
end

post '/search' do
  redirect "/entry/#{params[:query]}"
end

delete '/feeds/:id' do
  feed = Feed.only(:_id).find(params[:id])
  feed.entries.destroy
  feed.destroy
  redirect '/feeds'
end

get '/duplicate' do
  @dup = Duplicate
  slim :dup
end


# not_found do
#   "Whoops! You requested a route that wasn't available."
# end
