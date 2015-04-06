class Match
  def initialize(options)
    @players = options[:players]
    @times = options[:times] || 1
    @end_states = {}
  end

  def execute
    @players.each(&:start_match)
    @times.times do |game_count|
      log(:game, "---------------------Beginning Game #{game_count+1}---------------------".green)
      game = Game.new({
                          crises: GameConfig::CRISIS_CARDS.dup,
                          temptations: GameConfig::TEMPTATION_CARDS.dup,
                          players: @players
                      })
      game.execute
      @end_states[game.end_state] ||= 0
      @end_states[game.end_state] += 1
    end
    print_summary
    @players.each(&:end_match)
  end

  def print_summary
    puts "---------------------Game Results---------------------".green
    puts 'Players summary:'.green
    @players.each(&:print_summary)
    puts 'End conditions tally:'.green
    @end_states.sort.each { |k, v|
      print "#{k}: #{v}\n"
    }
    print "\n"
  end
end