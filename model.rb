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
class Feed
  include MongoMapper::Document
  
  key :title, String
  key :feed_url, String
  key :last_modified, Date
  many :entries
end

class Entry
  include MongoMapper::Document
  
  key :title, String
  key :url, String
  key :author, String
  key :content, String
  key :published, Date
end
