class AlwaysRandom < Persona
  def name
    'Random Strategy'
  end

  def choose_role
    random_role = [Role::ALTRUIST, Role::PRAGMATIST, Role::HOARDER, Role::OPPRESSOR]
    random_role[rand(random_role.length)]
  end
end