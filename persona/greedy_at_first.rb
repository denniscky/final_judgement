class GreedyAtFirst < Persona
  def name
    'Greedy at first'
  end

  def choose_role(game)
    if game.current_turn <= 3
      heart_share = ((game.crisis_this_turn).to_f / game.player_count).ceil - 1
      Role::get_by_heart_num(heart_share)
    else
      Role::ALTRUIST
    end
  end
end