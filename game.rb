class Game
  attr_reader :current_turn
  attr_reader :crisis_this_turn
  attr_reader :wealth_this_turn
  attr_reader :arma_level
  attr_reader :end_state

  ENDED_BY_WEALTH = 'by wealth'
  ENDED_BY_DESTRUCTION = 'by destruction'

  def initialize(options)
    seat_players(options)
    set_decks(options)
    reset_dials
  end

  def set_decks(options)
    @crises = options[:crises]
    @temptations = options[:temptations]
    @crises_left = @crises
    @temptations_left = @temptations
  end

  def reset_dials
    @arma_level = 0
    @current_turn = 1
  end

  def seat_players(options)
    @players = options[:players]
    @players.each { |p|
      p.start_new_game
    }
  end

  def execute
    while true
      reveal_cards
      players_choose_roles
      distribute_karma
      adjust_arma_level
      distribute_wealth
      print_statuses

      world_ending = check_world_end
      log(:game, "Current armageddo-meter: #{@arma_level}. World is #{world_ending ? '' : 'not '}ending.".cyan)

      break if world_ending
      break if @current_turn == GameConfig::NUM_TURNS

      @current_turn += 1
    end

    process_win_loss
  end

  def reveal_cards
    @crisis_this_turn = @crises_left.delete_at(rand(@crises_left.length))
    @wealth_this_turn = @temptations_left.delete_at(rand(@temptations_left.length))
    log(:game, "Begin Turn #{turn_number}: #{('Crisis = ' + @crisis_this_turn.to_s).red}, #{('Wealth = ' + @wealth_this_turn.to_s).yellow}, #{('Armageddo-meter = ' + @arma_level.to_s).magenta}".cyan)
  end

  def players_choose_roles
    @players.each { |p|
      p.choose_and_save_role(self)
    }
  end

  def distribute_karma
    @players.each { |p|
      p.receive_karma(p.chosen_hearts)
    }
  end

  def adjust_arma_level
    @arma_level = @arma_level - @crisis_this_turn
    @players.each { |p|
      @arma_level += p.chosen_hearts
    }
    @arma_level = [@arma_level, GameConfig::MAX_ARMA_LEVEL].min
    @arma_level = [@arma_level, GameConfig::MIN_ARMA_LEVEL].max
  end

  def distribute_wealth

    # @wealth_this_turn = 10

    played_money = @players.map(&:chosen_money).uniq
    while true do
      stop_distribution = false
      played_money.sort_by{|m|-m}.each { |num_money|
        players_who_played_this_amount = @players.select{|p| p.chosen_money == num_money}
        num_players_to_split = players_who_played_this_amount.length
        debug "Splitting #{@wealth_this_turn} wealth among #{num_players_to_split} players who played #{num_money} money"

        if @wealth_this_turn < num_players_to_split
          stop_distribution = true
          break
        end

        wealth_each_gets = [@wealth_this_turn / num_players_to_split, num_money].min
        players_who_played_this_amount.each do |player|
          player.receive_wealth(wealth_each_gets)
        end
        @wealth_this_turn -= num_players_to_split * wealth_each_gets
      }
      break if stop_distribution
    end
  end

  def print_statuses
    @players.each do |p|
      log(:game, p.status_str)
    end
  end

  def check_world_end
    return false if @arma_level >= 0
    players_with_highest_karma.length == 1 ? true : false
  end

  def process_win_loss
    @end_state = "Turn #{turn_number}"
    @players.each(&:increment_game_count)
    if turn_number < GameConfig::NUM_TURNS || @arma_level < 0
      unless players_with_highest_karma.length == GameConfig::NUM_PLAYERS
        players_with_highest_karma.each(&:set_win)
        players_with_lowest_karma.each(&:set_loss)
      end
      end_reason = ENDED_BY_DESTRUCTION
    else
      unless players_with_highest_wealth.length == GameConfig::NUM_PLAYERS
        players_with_highest_wealth.each(&:set_win)
        players_with_lowest_wealth.each(&:set_loss)
      end
      end_reason = ENDED_BY_WEALTH
    end
    log(:game, "Game ended on Turn #{turn_number}. Reason: #{end_reason == ENDED_BY_DESTRUCTION ? end_reason.red : end_reason.yellow}".cyan)
    @end_state += " #{end_reason}"
  end

  def player_count
    @players.length
  end

  def players_with_highest_karma
    @players.select{|p|p.num_karma == @players.map(&:num_karma).max}
  end

  def players_with_lowest_karma
    @players.select{|p|p.num_karma == @players.map(&:num_karma).min}
  end

  def players_with_highest_wealth
    @players.select{|p|p.num_wealth == @players.map(&:num_wealth).max}
  end

  def players_with_lowest_wealth
    @players.select{|p|p.num_wealth == @players.map(&:num_wealth).min}
  end

  def turn_number
    @current_turn
  end

  def effective_crisis_level
    @crisis_this_turn - @arma_level
  end

  def average_hearts_needed
    effective_crisis_level.to_f / player_count
  end

  def to_s
    str = ''
    str += "[DEBUG] Current turn           : #{turn_number}\n"
    str += "[DEBUG] Current crisis         : #{@crisis_this_turn}\n"
    str += "[DEBUG] Current temptation     : #{@wealth_this_turn}\n"
    str += "[DEBUG] Current armageddo-meter: #{@arma_level}\n"
    @players.each_with_index { |p,i|
      str += "[DEBUG] Player #{i}: #{p.to_s}\n"
    }
    str
  end
end