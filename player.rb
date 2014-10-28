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
  end

  def name
    raise 'Name not implemented'
  end

  def choose_role(game)
    raise 'Strategy not implemented'
  end

  def receive_karma(amount)
    @num_karma += amount
    puts "Player receives #{amount} karma as #{chosen_role}. Total karma: #{@num_karma}"
  end

  def receive_wealth(amount)
    @num_wealth += amount
    puts "Player receives #{amount} wealth as #{chosen_role}. Total wealth: #{@num_wealth}"
  end

  def chosen_money
    @chosen_role[:num_money]
  end

  def chosen_hearts
    @chosen_role[:num_hearts]
  end

  def chosen_role
    @chosen_role[:name]
  end

  def set_win_loss(has_won: has_won)
    @num_wins += 1 if has_won
    @num_losses += 1 if !has_won
  end

  def to_s
    "[#{name}] Karma=#{@num_karma}; Wealth=#{@num_wealth}; Recent play=#{chosen_role}; Win=#{@num_wins}; Loss=#{@num_losses}"
  end
end