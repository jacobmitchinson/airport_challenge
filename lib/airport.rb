require_relative 'weather_module.rb'

class Airport 

  include Weather

  attr_accessor :capacity 
  
  DEFAULT_CAPACITY = 6

  def initialize
    @planes ||= []
    @capacity ||= DEFAULT_CAPACITY
  end

  def count_planes 
    @planes.count
  end

  def land(plane)
    raise "You can't land in the middle of storm!" if stormy?
    raise 'Airport is full' if full?
    plane.landed
    @planes << plane 
  end

  def take_off(plane)
    raise "You can't take off in the middle of a storm!" if stormy?
    plane.take_off
    plane.in_air
    @planes.delete(plane)
  end

  def planes_in_air
    # create and in air method to track planes in the air 
  end

  def full? 
    count_planes == @capacity
  end

  def all_planes
    @planes
  end  

end