module Weather

  def stormy?
    # it is either sunny or stormy
    rand(10) == 1 ? true : false
  end

end