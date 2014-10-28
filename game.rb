require_relative 'player'

class Game
  NUM_TURNS = 7
  MAX_ARMA_LEVEL = 3
  MIN_ARMA_LEVEL = -3

  attr_reader :current_turn
  attr_reader :end_state

  def initialize(options)
    @crises = options[:crises]
    @temptations = options[:temptations]
    @players = options[:players]

    @arma_level = 0
    @crises_left = @crises
    @temptations_left = @temptations
    @current_turn = 1

    @players.each { |p|
      p.start_new_game
    }
  end

  def execute
    puts 'Begin Game'

    while true
      begin_turn

      choose_role
      distribute_karma
      adjust_arma_level

      world_ending = check_world_end
      puts "Current armageddo-meter: #{@arma_level}. World is #{world_ending ? '' : 'not '}ending."
      break if world_ending

      distribute_wealth

      break if @current_turn == NUM_TURNS
      @current_turn += 1
    end

    process_winner

    # puts self
  end

  def begin_turn
    puts "Begin Turn #{turn_number}"
    @crisis_this_turn = @crises_left.delete_at(rand(@crises_left.length))
    @wealth_this_turn = @temptations_left.delete_at(rand(@temptations_left.length))

  end

  def choose_role
    @players.each { |p|
      p.choose_role(self)
    }
  end

  def distribute_karma
    @players.each { |p|
      p.receive_karma(p.chosen_hearts)
    }
  end

  def distribute_wealth
    played_money = @players.map(&:chosen_money).uniq
    while true do
      played_money.sort_by{|m|-m}.each { |num_money|

        players_who_played_this_amount = @players.select{|p| p.chosen_money == num_money}
        num_players_to_split = players_who_played_this_amount.length

        # puts "Splitting #{@wealth_this_turn} wealth among #{num_players_to_split} players who played #{num_money} money"

        break if @wealth_this_turn < num_players_to_split

        wealth_each_gets = 0
        while @wealth_this_turn >= num_players_to_split && wealth_each_gets < num_money do
          wealth_each_gets += 1
          @wealth_this_turn -= num_players_to_split
        end

        players_who_played_this_amount.each do |player|
          player.receive_wealth(wealth_each_gets)
        end
      }
      break
    end
  end

  def adjust_arma_level
    @arma_level = @arma_level - @crisis_this_turn
    @players.each { |p|
      @arma_level += p.chosen_hearts
    }
    @arma_level = [@arma_level, MAX_ARMA_LEVEL].min
    @arma_level = [@arma_level, MIN_ARMA_LEVEL].max
    return @arma_level < 0
  end

  def check_world_end
    return false if @arma_level >= 0
    players_with_highest_karma.length == 1 ? true : false
  end

  def process_winner
    puts "Game ended on Turn #{turn_number}."
    @end_state = "Turn #{turn_number}"
    if turn_number < NUM_TURNS
      players_with_highest_karma[0].set_win_loss(has_won: true)
    else
      if @arma_level >= 0
        players_with_highest_karma(players_with_highest_wealth).each{|p|p.set_win_loss(has_won: true)}
        @end_state += '(By wealth)'
      else
        players_with_highest_karma.each{|p|p.set_win_loss(has_won: true)}
        @end_state += '(End)'
      end
    end
  end

  def players_with_highest_karma(players = @players)
    players.select{|p|p.num_karma == players.map(&:num_karma).max}
  end

  def players_with_highest_wealth
    @players.select{|p|p.num_wealth == @players.map(&:num_wealth).max}
  end

  def turn_number
    @current_turn
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