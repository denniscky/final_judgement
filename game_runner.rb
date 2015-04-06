class GameRunner
  def initialize(options)
    @players = options[:players]
    @times = options[:times] || 1
    @end_states = {}
  end

  def execute
    game_count = 1
    @times.times do
      puts "---------------------Beginning Game #{game_count}---------------------".green
      game = Game.new({
                          crises: GameConfig::CRISIS_CARDS.dup,
                          temptations: GameConfig::TEMPTATION_CARDS.dup,
                          players: @players
                      })
      game.execute
      @end_states[game.end_state] ||= 0
      @end_states[game.end_state] += 1
      game_count += 1
    end
  end

  def print_summary
    puts "---------------------Game Results---------------------".green
    puts 'Players summary:'.green
    @players.each(&:print_summary)
    puts 'End conditions tally:'.green
    @end_states.sort.each { |k, v|
      puts "#{k}: #{v}\n"
    }
  end
end