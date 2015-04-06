
# An abstract concept of a player's "brain". It contains attributes about the game/player that is not an inherent nature of the game or the player him/herself
class CerebralCortex
  def initialize(options)
    @me = options[:me]
    @game = options[:game]
  end

  def effective_crisis_level
    @game.crisis_this_turn - @game.arma_level
  end

  def average_hearts_needed
    effective_crisis_level.to_f / @game.player_count
  end

  def other_players
    @game.players_public_information.reject{|p| p[:object_id] == @me.object_id}
  end

  def karma_lag
    other_players.map{|p| p[:karma]}.max - @me.num_karma
  end
end