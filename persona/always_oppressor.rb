class AlwaysOppressor < Persona
  def name
    'Oppressor Strategy'
  end

  def choose_role
    Role::OPPRESSOR
  end
end