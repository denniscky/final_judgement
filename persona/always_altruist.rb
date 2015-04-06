class AlwaysAltruist < Persona
  def name
    'Altruist Strategy'
  end

  def choose_role(game)
    Role::ALTRUIST
  end
end