class PlayerAltruist < Player
  def name
    'Altruist Strategy'
  end

  def choose_role(game)
    @chosen_role = Role::ALTRUIST
  end
end