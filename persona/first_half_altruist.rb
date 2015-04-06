class FirstHalfAltruist < Persona
  def name
    'First Half Altruist'
  end

  def choose_role(game)
    if game.current_turn <= 3
      Role::ALTRUIST
    else
      Role::OPPRESSOR
    end
  end
end