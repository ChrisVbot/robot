
class BoxOfBolts < Item
  
  def initialize
    super('Box of bolts', 25)
  end

  def feed(robot_instance)
      robot_instance.heal(20)
    
  end

end
