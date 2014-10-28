class PlayerOppressor < Player
  def name
    'Oppressor Strategy'
  end

  def choose_role(game)
    @chosen_role = Role::OPPRESSOR
  end
end