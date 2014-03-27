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

#DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/feeds.db")
class Feed
  #include DataMapper::Resource
  include Mongoid::Document
  
  field :title,         type: String
  field :feed_url,      type: String
  field :last_modified, type: DateTime, default: ->{ DateTime.parse("1991 mar 1")}
  
  validates_presence_of :feed_url
  validates_uniqueness_of :feed_url
  
  has_many :entries
  
end


class Entry
  #include DataMapper::Resource
  include Mongoid::Document
  include Mongoid::Search
  
  field :title,     type: String
  field :url,       type: String
  field :author,    type: String
  field :content,   type: String
  field :published, type: DateTime
  
  validates_presence_of :title, :url, :content

  belongs_to :feed

  search_in :title, :content
  
end

class Duplicate
  #include DataMapper::Resource
  include Mongoid::Document
  
  field :feed_url_1,  type: String
  field :feed_url_2,  type: String
  field :title1,      type: String
  field :title2,      type: String
  field :author1,     type: String
  field :author2,     type: String
  field :content1,    type: String
  field :content2,    type: String
  field :similarity,  type: Float
  
  validates_presence_of :feed_url1, :feed_url2
end

#DataMapper.finalize
