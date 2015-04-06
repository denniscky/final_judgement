class ScaleByCrisis < Persona
  def name
    'Adjust by Crisis'
  end

  def choose_role(game)
    heart_share = ((game.crisis_this_turn).to_f / game.player_count).ceil
    Role::get_by_heart_num heart_share
  end
end