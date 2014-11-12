module Role
  ALTRUIST = {
      name: 'Altruist  ',
      num_hearts: 3,
      num_money: 1
  }
  PRAGMATIST = {
      name: 'Pragmatist',
      num_hearts: 2,
      num_money: 2
  }
  HOARDER = {
      name: 'Hoarder   ',
      num_hearts: 1,
      num_money: 3
  }
  OPPRESSOR = {
      name: 'Oppressor ',
      num_hearts: 0,
      num_money: 4
  }

  # return Role by number of hearts, expand range to beyond 0 and 3
  def self.get_by_heart_num(heart_num)
    if heart_num == 1
      HOARDER
    elsif heart_num == 2
      PRAGMATIST
    elsif heart_num <= 0
      OPPRESSOR
    else
      ALTRUIST
    end
  end
end

