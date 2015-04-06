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

GameConfig::LOG_LEVEL = :match

Ladder.new(
  personas: [
              AlwaysAltruist,
              FirstHalfAltruist,
              # FirstHalfOppressor,
              OppressorUnlessLeading,
              AlwaysRandom,
              Dennis,
              GreedyAtFirst,
              ScaleByCrisis
            ],
  num_rounds: 100).execute