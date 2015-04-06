require_relative 'role'

# Persona represents how a player will play the game (over multiple games)
class Persona
  MAX_NAME_LENGTH = 30
  attr_reader :num_karma
  attr_reader :num_wealth

  def initialize
    raise "A persona's name can only be at most #{MAX_NAME_LENGTH} characters" if name.length > MAX_NAME_LENGTH
    @num_wins = 0
    @num_losses = 0
    @num_games_played = 0
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
    raise "Role not chosen for turn #{game.current_turn}" if !role
    @roles_each_turn.push(role)
  end

  def choose_role(game)
    role = case game.current_turn
             when 1 then role_turn_1(game)
             when 2 then role_turn_2(game)
             when 3 then role_turn_3(game)
             when 4 then role_turn_4(game)
             when 5 then role_turn_5(game)
           end
    role = role_default(game) if !role
    role
  end

  def role_default(game)
    nil
  end

  def role_turn_1(game)
    nil
  end

  def role_turn_2(game)
    nil
  end

  def role_turn_3(game)
    nil
  end

  def role_turn_4(game)
    nil
  end

  def role_turn_5(game)
    nil
  end

  def receive_karma(amount)
    @num_karma += amount
    debug "#{'%30s'%name} receives #{amount} karma  as #{'%9s'%chosen_role_name}. Total karma : #{@num_karma}"
  end

  def receive_wealth(amount)
    @num_wealth += amount
    debug "#{'%30s'%name} receives #{amount} wealth as #{'%9s'%chosen_role_name}. Total wealth: #{@num_wealth}"
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

  def increment_game_count
    @num_games_played += 1
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

  def to_s
    summary_str
  end

  def status_str
    "#{'%30s'%name} - Karma =#{'%2d'%@num_karma}; Wealth =#{'%2d'%@num_wealth}; History=#{chosen_roles_history} #{@won_this_game ? 'Winner'.red : ''}#{@lost_this_game ? 'Loser'.red : ''}"
  end

  def print_summary
    puts summary_str
  end

  def summary_str
    "#{'%30s'%name} - Win =#{'%4d'%@num_wins}  Loss =#{'%4d'%@num_losses}  Played =#{'%4d'%@num_games_played}  Score =#{'%5d'%score}"
  end
end