require 'airport'
require 'plane'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land

describe Airport do

  let(:plane) { Plane.new }
  let(:airport) { Airport.new }

  context 'taking off and landing' do

    it 'a plane can land' do
      plane = double :plane
      allow(airport).to receive(:stormy?)
      allow(plane).to receive(:landed)
      expect{airport.land(plane)}.to change{airport.count_planes}.by 1
    end

    it 'a plane can take off' do
      allow(airport).to receive(:stormy?)
      plane = double :plane
      expect{airport.take_off(plane)}
    end
  end

  context 'traffic control' do

    it 'a plane cannot land if the airport is full' do
      plane = double :plane
      allow(plane).to receive(:landed)
      allow(airport).to receive(:stormy?)
      6.times { airport.land(plane) }
      expect(lambda { airport.land(plane) }).to raise_error(RuntimeError, 'Airport is full')
    end

    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport

    context 'weather conditions' do

      it 'a plane cannot take off when there is a storm brewing' do
        allow(airport).to receive(:stormy?).and_return(true)
        expect(lambda { airport.take_off(plane) }).to raise_error(RuntimeError, "You can't take off in the middle of a storm!")
      end

      it 'a plane cannot land in the middle of a storm' do
        allow(airport).to receive(:stormy?).and_return(true)
        expect(lambda { airport.land(plane) }).to raise_error(RuntimeError, "You can't land in the middle of storm!")
      end
    end
  end
end

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"

describe Plane do

  let(:plane) { Plane.new }
  let(:airport) { Airport.new }

  it 'has a flying status when created' do
    expect(plane.status).to eq "flying"
  end

  it 'has a flying status when in the air' do
    plane.in_air
    expect(plane.status).to eq "flying"
  end

  it 'can take off' do
    plane.take_off
    expect(plane.status).to eq 'taking off'
  end

  it 'changes its status to flying after taking of' do
    allow(airport).to receive(:stormy?)
    airport.take_off(plane)
    expect(plane.status).to eq "flying"
  end

  it 'changes its status to landed after landing' do 
    allow(airport).to receive(:stormy?)
    airport.land(plane)
    expect(plane.status).to eq "landed"
  end

end

# grand finale
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!

describe "The gand finale (last spec)" do

  let(:plane)  {Plane.new}
  let(:airport) { Airport.new }

 
  it 'all planes can land and all planes can take off' do
    allow(airport).to receive(:stormy?).and_return(false)
    6.times { airport.land(plane) } 
    expect(all_status_landed?(airport)).to be true 
    all_planes_take_off(airport.all_planes, airport)
    expect(airport.count_planes).to eq(0)
  end


  # helper methods

  def all_status_landed?(airport)
    airport.all_planes.all? do 
      plane.status == "landed"
    end
  end

  def all_status_flying?(airport)
    airport.all_planes.all? do 
      plane.status == "flying"
    end
  end

  def all_planes_take_off(all_planes, airport)
    all_planes.each do |plane|
       airport.take_off(plane)
    end
  end
end

