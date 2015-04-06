class OppressorUnlessLeading < Persona
  def name
    'Oppress unless leading'
  end

  def choose_role
    heart_share = @brain.average_hearts_needed.ceil
    if @game.current_turn == 1
      Role::OPPRESSOR
    else
      if @game.players_with_highest_wealth.include? self
        Role::get_by_heart_num(heart_share)
      else
        Role::OPPRESSOR
      end
    end
  end
end