require './lib/airport.rb'

class Plane

  attr_reader :status

  def initialize
    @status = "flying"
  end

  def in_air
    @status = "flying"
  end

  def take_off
    @status = "taking off"
  end

  def landed
    @status = "landed"
  end
  
end