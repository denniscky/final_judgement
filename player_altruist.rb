class PlayerAltruist < Player
  def name
    'Altruist Strategy'
  end

  def choose_role(game)
    Role::ALTRUIST
  end
end