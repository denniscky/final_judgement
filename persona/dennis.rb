class Dennis < Persona
  def name
    'Dennis'
  end

  # def role_turn_1(game)
  #   heart_share = ((game.effective_crisis_level).to_f / game.player_count).round
  #   if game.wealth_this_turn < 10
  #     heart_share += 1
  #   end
  #   Role::get_by_heart_num(heart_share)
  # end

  def role_default(game)
    heart_share = game.average_hearts_needed.round
    Role::get_by_heart_num(heart_share)
  end
end