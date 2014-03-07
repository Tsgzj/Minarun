# !/usr/bin/env ruby
# --
# FeedZirra.rb --- 
#
# Copyright (C) 2013  Sun Wenxiang<Tsgzj>
# Create: Wed Dec 25 10:26:40 2013
#
# Author: Sun Wenxiang <wxsun1991@gmail.com>
# Organization: Nanjing University
#
require 'feedzirra'
require 'nokogiri'
require 'mongo'

include Mongo

feed = Feedzirra::Feed.fetch_and_parse("http://www.theverge.com/rss/index.xml")
entry = feed.entry.first

db = Mongo::Connection.new["feeds"]
db['']
end

