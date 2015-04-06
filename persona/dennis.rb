class Dennis < Persona
  def name
    'Dennis'
  end

  # def role_turn_1
  #   heart_share = ((game.effective_crisis_level).to_f / game.player_count).round
  #   if game.wealth_this_turn < 10
  #     heart_share += 1
  #   end
  #   Role::get_by_heart_num(heart_share)
  # end

  def role_turn_1
    heart_share = @brain.average_hearts_needed.ceil
    Role::get_by_heart_num(heart_share)
  end

  def role_turn_2
    heart_share = @brain.average_hearts_needed.round
    heart_share = [heart_share, @brain.karma_lag].max
    Role::get_by_heart_num(heart_share)
  end
  def role_turn_3; role_turn_2; end
  def role_turn_4; role_turn_2; end
  def role_turn_5; role_turn_2; end
end