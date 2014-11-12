class PlayerFirstAltruist < Player
  def name
    'First Half Altruist'
  end

  def choose_role(game)
    if game.current_turn <= 4
      Role::ALTRUIST
    else
      Role::OPPRESSOR
    end
  end
end