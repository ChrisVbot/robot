require_relative 'item.rb'

class Robot

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
    # @position.map!{|left| (left == @position[0]) ? left -= 1 : left}
    @position[0] -= 1
  end

  #Moves the robot one space to the right
  def move_right
    @position[0] += 1
  end


  def move_up
    @position[1] += 1
  end

#to fix
  def move_down
    @position[1] -= 1
  end  

  def pick_up(item)
    if items_weight + item.weight <= CAPACITY 
      # && item.is_a?(Item)
      if item.is_a?(Weapon)
        @equipped_weapon = item
      else 
        items << item
      end
    end
  end

  def items_weight
    weight = @items.inject(0) do |sum, item|
      sum + item.weight
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

  def attack(enemy)
    if @equipped_weapon.nil?
      enemy.wound(DEFAULT_ATTACK_DAMAGE)
    else
      @equipped_weapon.hit(enemy)
    end
  end


end
