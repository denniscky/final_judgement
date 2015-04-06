class FirstHalfOppressor < Persona
  def name
    'First Half Oppressor'
  end

  def choose_role
    if @game.current_turn <= 3
      Role::OPPRESSOR
    else
      Role::ALTRUIST
    end
  end
end