#!/usr/bin/env ruby

Dir['./*.rb'].each {|file|
  require_relative file
}

players = [
    PlayerRandom.new,
    PlayerFirstAltruist.new,
    PlayerAltruist.new,
    PlayerFirstOppressor.new
]

runner = GameRunner.new(players: players)
runner.execute
puts runner