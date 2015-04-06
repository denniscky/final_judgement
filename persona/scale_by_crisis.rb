class ScaleByCrisis < Persona
  def name
    'Adjust by Crisis'
  end

  def choose_role
    heart_share = @brain.average_hearts_needed.ceil - 1
    Role::get_by_heart_num heart_share
  end
end