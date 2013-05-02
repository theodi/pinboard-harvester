#!/usr/bin/env ruby

require 'dotenv'
Dotenv.load

require 'active_support/core_ext'

require 'pinboard'
require 'mongo'
require 'resque'
require 'resque_scheduler'
require 'resque/scheduler'
require './lib/pinboard_harvester'
require './lib/pinboard_store'

Resque.enqueue(PinboardHarvester, 1)