class GameRunner
  def initialize(options)
    @players = options[:players]
    @times = options[:times] || 1
    @end_states = {}
  end

  def execute
    count = 1
    @times.times do
      puts "---------------------Beginning Game #{count}---------------------".green
      game = Game.new({
                          crises: GameConfig::CRISIS_CARDS.dup,
                          temptations: GameConfig::TEMPTATION_CARDS.dup,
                          players: @players
                      })
      game.execute
      @end_states[game.end_state] ||= 0
      @end_states[game.end_state] += 1
      count += 1
    end
  end

  def to_s
    txt = @players.each(&:to_s).join("\n") + "\nEnd conditions tally:\n"
    @end_states.sort.each { |k, v|
      txt += "#{k}: #{v}"
    }
    txt
  end
end