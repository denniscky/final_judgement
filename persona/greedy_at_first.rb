class GreedyAtFirst < Persona
  def name
    'Greedy at first'
  end

  def choose_role
    if @game.current_turn <= 3
      heart_share = @brain.average_hearts_needed.ceil - 1
      Role::get_by_heart_num(heart_share)
    else
      Role::ALTRUIST
    end
  end
end