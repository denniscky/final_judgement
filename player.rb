require_relative 'role'

class Player
  attr_reader :num_karma
  attr_reader :num_wealth

  def initialize
    @num_wins = 0
    @num_losses = 0
  end

  def start_new_game
    @num_karma = 0
    @num_wealth = 0
    @roles_each_turn = []
  end

  def name
    raise 'Name not implemented'
  end

  def choose_and_save_role(game)
    role = choose_role(game)
    raise 'Role not chosen' if !role
    @roles_each_turn.push(role)
  end

  def choose_role(game)
    raise 'Strategy not implemented'
  end

  def receive_karma(amount)
    @num_karma += amount
    puts "[#{'%20s'%name}] receives #{amount} karma as #{chosen_role_name}. Total karma: #{@num_karma}"
  end

  def receive_wealth(amount)
    @num_wealth += amount
    puts "[#{'%20s'%name}] receives #{amount} wealth as #{chosen_role_name}. Total wealth: #{@num_wealth}"
  end

  def chosen_money
    chosen_role[:num_money]
  end

  def chosen_hearts
    chosen_role[:num_hearts]
  end

  def chosen_role_name
    chosen_role[:name]
  end

  def chosen_role
    @roles_each_turn[-1]
  end

  def chosen_roles_history
    @roles_each_turn.map{|r|r[:num_hearts]}.join(',')
  end

  def set_win
    @num_wins += 1
  end

  def set_loss
    @num_losses += 1
  end

  def score
    @num_wins - @num_losses
  end

  def to_s
    "[#{'%20s'%name}] " +
        "Karma=#{'%2d'%@num_karma}; Wealth=#{'%2d'%@num_wealth}; " +
        "Plays=#{chosen_roles_history}; " +
        "Win=#{'%4d'%@num_wins}; Loss=#{'%4d'%@num_losses}; Score=#{'%4d'%score}"
  end
end