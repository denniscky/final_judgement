class PlayerFirstOppressor < Player
  def name
    'First Half Oppressor'
  end

  def choose_role(game)
    if game.current_turn <= 4
      Role::OPPRESSOR
    else
      Role::ALTRUIST
    end
  end
end