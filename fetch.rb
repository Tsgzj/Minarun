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
#require 'feedjira'
require 'feedzirra'
require 'mongoid'
require 'matrix'
require 'gsl'
require 'tf-idf-similarity'
require 'nokogiri'
require "./app"

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
      doc1_content = TfIdfSimilarity::Document.new(Nokogiri::HTML(entry.content).text)
      doc1_title = TfIdfSimilarity::Document.new(entry.title)
      dup = false
      Entry.all.each do |compare|
        doc2_content = TfIdfSimilarity::Document.new(Nokogiri::HTML(compare.content).text)
        doc2_title = TfIdfSimilarity::Document.new(compare.title)

        #puts compare.id.to_s
        corpus_content = []
        corpus_content << doc1_content
        corpus_content << doc2_content

        corpus_title = []
        corpus_title << doc1_title
        corpus_title << doc2_title
        
        model_content = TfIdfSimilarity::TfIdfModel.new(corpus_content, :library =>  :gsl)
        model_title = TfIdfSimilarity::TfIdfModel.new(corpus_title, :library => :gsl)

        similar_content = model_content.similarity_matrix[0,1]
        similar_title = model_title.similarity_matrix[0,1]

        if similar_content > 0.24 || similar_title > 0.5
          puts "Duplicate!" + entry.title + " " + compare.title + "Title_similarity: #{similar_title} Content Similarity: #{similar_content}"
          Duplicate.create(feed_url1: entry.url,    feed_url2: compare.url,
                           title1: entry.title,     title2: compare.title,
                           author1: entry.author,   author2: compare.author,
                           content1: entry.content, content2: compare.content
                           )
          dup = true
          break
        end
      end
      
      if !dup
        e.entries.create(title: entry.title,
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

