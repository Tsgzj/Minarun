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

Feedzirra::Feed.fetch_and_parse("http://www.theverge.com/rss/index.xml").entries.each do |e|
  puts Nokogiri::HTML(e.content).text
end

