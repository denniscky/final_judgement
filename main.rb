#!/usr/bin/env ruby

require_relative 'game'
require_relative 'player'
require_relative 'player_altruist'
require_relative 'player_first_altruist'
require_relative 'player_oppressor'
require_relative 'player_random'
require_relative 'role'

players = [PlayerOppressor.new, PlayerAltruist.new, PlayerRandom.new, PlayerRandom.new]
end_states = {}
5000.times do
  game = Game.new({
                      crises: [3,4,5,5,6,6,7,8],
                      temptations: [6,7,8,9,10,11,12,13],
                      players: players
                  })
  game.execute
  end_states[game.end_state] ||= 0
  end_states[game.end_state] += 1
end
puts players
end_states.sort.each { |k, v|
  puts "#{k}: #{v}"
}