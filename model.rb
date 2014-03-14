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
# end

# class Entry
#   key :feed_url, String
#   key :title, String
#   key :url, String
#   key :author, String
#   key :content, String
#   key :published, Date
# end


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/feeds.db")

class Entry
  include DataMapper::Resource
  
  property :id,        Serial
  property :feed_url,  Text, :required => true #String has default max length of 50
  property :title,     Text, :required => true #Using Text instead
  property :url,       Text, :required => true
  property :author,    Text
  property :content,   Text, :required => true
  property :published, DateTime
end

class Feed
  include DataMapper::Resource
  
  property :id,            Serial
  property :title,         Text
  property :feed_url,      Text, :required => true, :unique => true
  property :last_modified, DateTime
end

class Duplicate
  include DataMapper::Resource
  
  property :id, Serial
  property :feed1_url,  Text, :required => true
  property :feed2_url,  Text, :required => true
  property :title1,     Text
  property :title2,     Text
  property :author1,    Text
  property :author2,    Text
  property :content1,   Text
  property :content2,   Text
  property :similarity, Float
end

DataMapper.finalize
