#!/usr/bin/env ruby
require 'colored'
require_relative 'game_config.rb'
require_relative 'role.rb'
require_relative 'cerebral_cortex.rb'
require_relative 'persona.rb'
require_relative 'game.rb'
require_relative 'match.rb'
require_relative 'ladder.rb'
Dir['persona/*.rb'].each {|file| require_relative file }

GameConfig::LOG_LEVEL = :game

Match.new(
  players: [
             # AlwaysRandom.new,
             FirstHalfAltruist.new,
             Dennis.new,
             ScaleByCrisis.new,
             # FirstHalfAltruist.new,
             # FirstHalfAltruist.new
             # AlwaysAltruist.new,
             # AlwaysAltruist.new,
             # AlwaysAltruist.new,
             FirstHalfOppressor.new
           ],
  times: 100
).execute
