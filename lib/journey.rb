class Journey

attr_reader :entry, :exit
MINIMUM_FARE = 1
PENALTY_FARE = 6

  def start(station)
    @entry = station
  end

  def complete?
    !@exit.nil? && !@entry.nil?
  end

  def finish(station)
    @exit = station
  end

  def fare
    return MINIMUM_FARE if complete?
    return PENALTY_FARE unless @entry.nil? && @exit.nil?
    0
  end
end
