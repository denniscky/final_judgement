#!/usr/bin/env ruby
require 'colored'
require_relative 'game_config.rb'
require_relative 'role.rb'
require_relative 'persona.rb'
require_relative 'game.rb'
require_relative 'match.rb'
require_relative 'ladder.rb'
Dir['persona/*.rb'].each {|file| require_relative file }

# Match.new(
#   players: [
#              # Dennis.new,
#              # AlwaysRandom.new,
#              # FirstHalfAltruist.new,
#              AlwaysAltruist.new,
#              AlwaysAltruist.new,
#              AlwaysAltruist.new,
#              FirstHalfOppressor.new
#            ],
#   times: 100
# ).execute

ladder = Ladder.new(
  personas: [
              AlwaysAltruist,
              FirstHalfAltruist,
              FirstHalfOppressor,
              OppressorUnlessLeading,
              AlwaysRandom
            ],
  num_rounds: 5).execute