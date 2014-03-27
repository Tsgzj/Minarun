# !/usr/bin/env ruby
# --
# feedjira.rb --- 
#
# Copyright (C) 2013  Sun Wenxiang<Tsgzj>
# Create: Thu Mar 27 00:25:54 2014
#
# Author: Sun Wenxiang <wxsun1991@gmail.com>
# Organization: Nanjing University
#
# F**k you Feedjira!

require 'feedjira'
require 'feedzirra'

feed = Feedjira::Feed.fetch_and_parse("http://feeds.arstechnica.com/arstechnica/index?format=xml")

feed.entries.each do |e|
  puts e.url + " " + e.updated.to_s
end

#feed2 = Feedzirra::Feed.fetch_and_parse("http://feeds.arstechnica.com/arstechnica/index?format=xml")

feed2 = Feedzirra::Feed.fetch_and_parse("http://feeds.arstechnica.com/arstechnica/index?format=xml")

feed2.entries.each do |e|
  puts e.url
end

