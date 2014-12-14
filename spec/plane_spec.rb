require 'plane'
require 'weather_module'

describe Plane do

  let(:plane) { Plane.new }

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
    airport = double(take_off: plane.in_air)
    airport.take_off(plane)
    expect(plane.status).to eq "flying"
  end

  it 'changes its status to landed after landing' do 
     airport = double(land: plane.landed)
    airport.land(plane)
    expect(plane.status).to eq "landed"
  end
end