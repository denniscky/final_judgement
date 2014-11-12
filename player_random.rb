class PlayerRandom < Player
  def name
    'Random Strategy'
  end

  def choose_role(game)
    random_role = [Role::ALTRUIST, Role::PRAGMATIST, Role::HOARDER, Role::OPPRESSOR]
    random_role[rand(random_role.length)]
  end
end