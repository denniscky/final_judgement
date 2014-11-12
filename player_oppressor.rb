class PlayerOppressor < Player
  def name
    'Oppressor Strategy'
  end

  def choose_role(game)
    Role::OPPRESSOR
  end
end