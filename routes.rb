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

get '/feeds' do
  @feeds = Feed.all
  slim :feed
end

#post '/feeds' do

not_found do
  "Whoops! You requested a route that wasn't available."
end

