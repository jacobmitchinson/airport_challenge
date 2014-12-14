require 'airport'
require 'plane'
require 'weather_module'

describe "the grand finale (last spec)" do

  let(:plane)  {Plane.new}
  let(:airport) { Airport.new }
 
  it 'all planes can land and all planes can take off' do
    allow(airport).to receive(:weather).and_return('sunny')
    land_six_planes(airport)
    all_planes_take_off(airport.all_planes, airport)
    expect(airport.count_planes).to eq(0)
  end

  it 'all planes should have status landed' do
    allow(airport).to receive(:weather).and_return('sunny')
    land_six_planes(airport)
    expect(all_status_landed?(airport)).to be true
  end

  # helper methods

  def land_six_planes(airport)
    6.times { airport.land(plane) } 
  end


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
