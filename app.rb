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
#require 'data_mapper'
require 'slim'
require 'mongo'
require 'mongoid'
require 'mongoid_search'
require "./routes"
require "./model"
require "./helpers"
#require 'mongo'
#require 'mongo_mapper'
require 'bson'

Mongoid.load!("Mongoid.yml")
