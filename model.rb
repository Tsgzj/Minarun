# !/usr/bin/env ruby
# --
# model.rb --- 
#
# Copyright (C) 2013  Sun Wenxiang<Tsgzj>
# Create: Fri Mar  7 21:35:33 2014
#
# Author: Sun Wenxiang <wxsun1991@gmail.com>
# Organization: Nanjing University
#
# class Feed

#   key :title, String
#   key :feed_url, String
#   key :last_modified, Date
#   many :entries
# end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/feeds.db")

class Entry
  include DataMapper::Resource
  
  property :id, Serial
  property :feed_url, Text, :required => true
  property :title, Text, :required => true
  property :url, Text, :required => true
  property :author, Text
  property :content, Text, :required => true
  property :published, DateTime
end

class Feed
  include DataMapper::Resource
  
  property :id, Serial
  property :title, Text
  property :custom_title, Text
  property :feed_url, Text, :required => true, :unique => true
  property :last_modified, DateTime
end

DataMapper.finalize
