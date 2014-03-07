# !/usr/bin/env ruby
# --
# app.rb --- 
#
# Copyright (C) 2013  Sun Wenxiang<Tsgzj>
# Create: Tue Mar  4 11:15:14 2014
#
# Author: Sun Wenxiang <wxsun1991@gmail.com>
# Organization: Nanjing University
#
require 'sinatra'
require 'mongo'
require 'bson'
require 'mongo_mapper'
require "./routes"
require "./model"
require "./helpers"

include Mongo

configure do
  conn = MongoClient.new("localhost", 27017)
  set :mongo_connection, conn
  set :mongo_db, conn.db('feeds')
end
