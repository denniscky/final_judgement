class GameRunner
  TIMES = 1000
  CRISES = [5,6,6,7,7,8,8,9]
  TEMPTATIONS = [7,8,9,10,11,12,13,6]

  def initialize(options)
    @players = options[:players]
    @end_states = {}
  end

  def execute
    count = 1
    TIMES.times do
      puts '-------------------------------------------------------'
      puts "Begin Game #{count}"
      game = Game.new({
                          crises: CRISES.dup,
                          temptations: TEMPTATIONS.dup,
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