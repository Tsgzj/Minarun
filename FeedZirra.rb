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

Feed.all.each do |e|
  feed = Feedzirra::Feed.fetch_and_parse(e.feed_url)
  feed.entries.each do |entry|
    #judge whether the entry is new by compare time published
    if DateTime.parse(entry.published.to_s) > DateTime.parse(e.last_modified.to_s)
      Entry.create(title: entry.title, feed_url: e.feed_url, url: entry.url, author: entry.author, content: entry.content, published: entry.published)
      puts "update!"
    end
  end
  
  e.update(last_modified: feed.last_modified) #update the modified time for next fetch
end



