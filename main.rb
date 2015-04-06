#!/usr/bin/env ruby
require 'colored'
Dir['./*.rb'].each {|file| require_relative file }
Dir['persona/*.rb'].each {|file| require_relative file }

players = [
    AlwaysRandom.new,
    FirstHalfAltruist.new,
    AlwaysAltruist.new,
    FirstHalfOppressor.new
]

runner = GameRunner.new(players: players, times: 1000)
runner.execute
puts runner