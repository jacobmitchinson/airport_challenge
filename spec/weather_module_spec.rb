require 'weather_module'

describe Weather do 

  class WeatherModule; include Weather; end

  let(:weather_test) { WeatherModule.new}

  it 'should return stormy' do
    allow(weather_test).to receive(:random_number).and_return(1)
    expect(weather_test.weather).to eq 'stormy'
  end

  it 'should return sunny' do 
    allow(weather_test).to receive(:random_number).and_return(5)
    expect(weather_test.weather).to eq 'sunny'
  end

end
