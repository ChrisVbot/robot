require_relative 'item.rb'

class Robot

  class UnattackableEnemyError < StandardError
  end

  class RobotAlreadyDead < RuntimeError
  end

CAPACITY = 250
DEFAULT_ATTACK_DAMAGE = 5

attr_reader :position, :items, :health
attr_accessor :equipped_weapon

  def initialize
    @position = position
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
  end


  #Moves the robot one space to the left
  def move_left
    @position[0] -= 1
  end

  #Moves the robot one space to the right
  def move_right
    @position[0] += 1
  end

  #Moves the robot one space up
  def move_up
    @position[1] += 1
  end
  #Moves the robot one space down
  def move_down
    @position[1] -= 1
  end  

  #Picks up the item if robot is not at max capaciy and item is not too heavy
  def pick_up(item)
    if items_weight + item.weight <= CAPACITY 
      if item.is_a?(Weapon)
        @equipped_weapon = item  
      elsif item.is_a?(BoxOfBolts) && health <= 80
          item.feed(self) 
      else items << item
      end
    end
  end

  #Checks the weight of an item
  def items_weight
    weight = @items.inject(0) do |sum, item|
      sum + item.weight
    end
  end
  
  #Attacks if the enemy is within 1 space. If current weapon is a grenade & enemy is within 2 spaces, runs explode method. 
  def attack(enemy)
    if @equipped_weapon.is_a?(Grenade)
      #Checks if enemy is within 2 spaces by comparing current player's position to enemy position.
      if enemy.position.inject(0){|sum, num| sum + num} == @position.inject(0) {|sum, num| sum + num} + 2 || 
        enemy.position.inject(0){|sum, num| sum - num} == @position.inject(0){|sum, num| sum - num} + 2
        grenade_explode(enemy)
      end
      #Checks if enemy is within 1 space by comparing with current position. 
    elsif enemy.position.inject(0){|sum, num| sum + num} == @position.inject(0) {|sum, num| sum + num} + 1 || 
        enemy.position.inject(0){|sum, num| sum - num} == @position.inject(0){|sum, num| sum - num} + 1 
      
      if @equipped_weapon.nil?
        enemy.wound(DEFAULT_ATTACK_DAMAGE)
      else 
        @equipped_weapon.hit(enemy)
      end
    end
 end

  #Attacks with grenade and drops it 
  def grenade_explode(enemy)
    @equipped_weapon.hit(enemy)
    @equipped_weapon = nil
  end

  def attack!(enemy)
    unless enemy.is_a?(Robot)
      raise UnattackableEnemy, 'cannot attack unless target is a robot!' 
    end
  end
  
  def wound(wound_amount)
    if @health < wound_amount
      @health = 0
    else
      @health -= wound_amount 
    end
  end

  def heal(heal_amount)
    if @health + heal_amount > 100
      @health = 100
    else
      @health += heal_amount
    end
  end

  def heal!
    raise RobotAlreadyDead, 'Robot is already dead' if health == 0
  end

end
