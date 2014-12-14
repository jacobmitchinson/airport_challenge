require 'airport'
require 'plane'
require 'weather_module'

describe Airport do

  let(:plane) { double :plane }
  let(:airport) { Airport.new }

  context 'taking off and landing' do

    it 'a plane can land' do
      allow(airport).to receive(:weather)
      allow(plane).to receive(:landed)
      expect{airport.land(plane)}.to change{airport.count_planes}.by 1
    end

    it 'a plane can take off' do
      allow(airport).to receive(:weather)
      expect{airport.take_off(plane)}
    end

  end

  context 'traffic control' do

    it 'a plane cannot land if the airport is full' do
      allow(plane).to receive(:landed)
      allow(airport).to receive(:weather)
      6.times { airport.land(plane) }
      expect(lambda { airport.land(plane) }).to raise_error(RuntimeError, 'Airport is full')
    end

    context 'weather conditions' do

      it 'a plane cannot take off when there is a storm brewing' do
        allow(airport).to receive(:weather).and_return('stormy')
        expect(lambda { airport.take_off(plane) }).to raise_error(RuntimeError, "You can't take off in the middle of a storm!")
      end

      it 'a plane cannot land in the middle of a storm' do
        allow(airport).to receive(:weather).and_return('stormy')
        expect(lambda { airport.land(plane) }).to raise_error(RuntimeError, "You can't land in the middle of storm!")
      end
    end
  end
end


