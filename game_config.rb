module GameConfig

  DEBUG_MODE = false

  NUM_TURNS = 5
  MAX_ARMA_LEVEL = 3
  MIN_ARMA_LEVEL = -3

  CRISIS_CARDS = [5,6,6,7,7,8,8,9]
  TEMPTATION_CARDS = [6,7,8,9,10,11,12,13]

end

def debug(s)
  puts s.to_s.white_on_red if GameConfig::DEBUG_MODE
end