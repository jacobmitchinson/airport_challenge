module Weather

  def weather
    # it is either sunny or stormy
    random_number == 1 ? 'stormy' : 'sunny'
  end

  def random_number
    rand(10)
  end

end