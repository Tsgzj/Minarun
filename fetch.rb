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
require 'matrix'
require 'tf-idf-similarity'
require 'nokogiri'
require "./model"

Feed.all.each do |e|
  feed = Feedzirra::Feed.fetch_and_parse(e.feed_url)
  feed.entries.each do |entry|
    # judge whether the entry is new by compare time published
    # DataMapper::Property::DateTime has no > mothods, need to convert to DateTime class
    # and then compare them
    # TODO
    # There may be some better solution
    # they find if there is any duplicate
    
    if DateTime.parse(entry.published.to_s) > DateTime.parse(e.last_modified.to_s)
      doc1 = TfIdfSimilarity::Document.new(Nokogiri::HTML(entry.content).text)
      dup = false
      Entry.all(:limit => 20, :order => [:published.desc]).each do |compare|
        doc2 = TfIdfSimilarity::Document.new(Nokogiri::HTML(compare.content).text)
        
        #puts compare.id.to_s
        corpus = []
        corpus << doc1
        corpus << doc2
        
        model = TfIdfSimilarity::TfIdfModel.new(corpus)
        similar = model.similarity_matrix[0,1]
        
        #puts similar.similarity_matrix[0,1]
        if similar > 0.8
          #puts "Duplicate!" + similar.to_s + doc1.content + doc2.content
          Duplicate.create(feed_url1: entry.url,    feed_url2: compare.url,
                           title1: entry.title,     title2: compare.title,
                           author1: entry.author,   author2: compare.author,
                           content1: entry.content, content2: compare.content,
                           similarity: similar)
          dup = true
          break
        end
      end
      
      if !dup
        Entry.create(title: entry.title,
                   feed_url: e.feed_url,
                   url: entry.url,
                   author: entry.author,
                   content: entry.content,
                   published: entry.published)
        puts "update!"
      end
    end
  end
  
  e.update(title: feed.title,
           last_modified: feed.last_modified) #update the modified time for next fetch
end
