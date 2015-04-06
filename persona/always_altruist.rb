class AlwaysAltruist < Persona
  def name
    'Altruist Strategy'
  end

  def choose_role
    Role::ALTRUIST
  end
end