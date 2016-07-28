
class BoxOfBolts < Item
  
  def initialize
    super('Box of bolts', 25)
  end

  def feed(robot)
    if robot.is_a? Robot
      robot.heal(20)
    end
  end

end
