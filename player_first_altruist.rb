class PlayerFirstAltruist < Player
  def name
    'First Half Altruist'
  end

  def choose_role(game)
    if game.current_turn <= 4
      @chosen_role = Role::ALTRUIST
    else
      random_role = [Role::PRAGMATIST, Role::HOARDER, Role::OPPRESSOR]
      @chosen_role = random_role[rand(random_role.length)]
    end
  end
end