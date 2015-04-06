require_relative 'role'

# Persona represents how a player will play the game (over multiple games)
class Persona
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
    @won_this_game = false
    @lost_this_game = false
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
    puts "#{'%24s'%name} receives #{amount} karma  as #{'%9s'%chosen_role_name}. Total karma : #{@num_karma}"
  end

  def receive_wealth(amount)
    @num_wealth += amount
    puts "#{'%24s'%name} receives #{amount} wealth as #{'%9s'%chosen_role_name}. Total wealth: #{@num_wealth}"
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
    @roles_each_turn.map{|r|r[:code]}.join(',')
  end

  def set_win
    @num_wins += 1
    @won_this_game = true
  end

  def set_loss
    @num_losses += 1
    @lost_this_game = true
  end

  def score
    @num_wins - @num_losses
  end

  def print_status
    puts "#{'%20s'%name} - Karma =#{'%2d'%@num_karma}; Wealth =#{'%2d'%@num_wealth}; History=#{chosen_roles_history} #{@won_this_game ? 'Winner'.red : ''}#{@lost_this_game ? 'Loser'.red : ''}"
  end

  def print_summary
    puts "#{'%20s'%name} - Win =#{'%4d'%@num_wins}; Loss =#{'%4d'%@num_losses}; Score =#{'%5d'%score}"
  end
end