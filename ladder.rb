class Ladder
  def initialize(options)
    @personas = options[:personas]
    @num_rounds = options[:num_rounds]
    @num_games_in_a_round = options[:num_games_in_a_round]
    @ladder = []
  end

  def execute
    (GameConfig::NUM_PLAYERS).times do
      @personas.each do |klass|
        @ladder.push klass.new
      end
    end

    @ladder.shuffle!
    @num_rounds.times do |round_count|
      log(:match, "---------------------Beginning Round #{round_count+1}---------------------".green)
      (@ladder.length / GameConfig::NUM_PLAYERS).times do |i|
        player_index = i*GameConfig::NUM_PLAYERS
        players = [
          @ladder[player_index],
          @ladder[player_index+1],
          @ladder[player_index+2],
          @ladder[player_index+3]
        ]
        Match.new(players: players, times: @num_games_in_a_round).execute
      end

      log(:match, "---------------------Concluding Round #{round_count+1}---------------------".green)
      @ladder.sort_by!{|p| -p.score}
      @ladder.each do |p|
        log(:match, p)
      end
    end

    # @ladder.each do |p|
    #   print "#{p.name}, "
    # end
    # print "\n"
    # @num_rounds.times do |round_count|
    #   @ladder.each do |p|
    #     print "#{p.score_history[round_count]}, "
    #   end
    #   print "\n"
    # end
  end
end

