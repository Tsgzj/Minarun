# !/usr/bin/env ruby
# --
# similarity.rb --- 
#
# Copyright (C) 2013  Sun Wenxiang<Tsgzj>
# Create: Wed Dec 25 12:40:47 2013
#
# Author: Sun Wenxiang <wxsun1991@gmail.com>
# Organization: Nanjing University
#
require 'similarity'

corpus = Corpus.new

doc1 = Document.new(:content => "A simple test for similarity")
doc2 = Document.new(:content => "Simple similarity test")
doc3 = Document.new(:content => "A similarity test using ruby")

[doc1, doc2, doc3].each { |doc| corpus << doc }

corpus.similar_documents(doc1).each do |doc, similarity|
  puts "Similarity between doc #{doc1.id} and doc #{doc.id} is #{similarity}"
end
