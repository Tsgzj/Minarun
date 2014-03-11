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
require 'data_mapper'
require "./model"


feed = Feedzirra::Feed.fetch_and_parse("http://www.theverge.com/rss/index.xml")

feed.entries.each do |entry|
  puts entry.title + " " + entry.url + "\n" + entry.content + "\n" 
  Entry.create(title: entry.title, url: entry.url, author: entry.author, content:
  entry.content, published: entry.published)
  #puts entry.published
end









