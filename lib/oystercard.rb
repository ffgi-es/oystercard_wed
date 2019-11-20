class Oystercard

  attr_reader :balance, :history
  MAX_BALANCE = 90

  def initialize(journey_class = Journey, min_fare = Journey::MINIMUM_FARE,
                  penalty_fare = Journey::PENALTY_FARE)
    @balance = 0
    @history = []
    @journey_class = journey_class
    @min_fare = min_fare
    @penalty_fare = penalty_fare
  end

  def top_up(value)
    raise "top up over max balance" if @balance + value > MAX_BALANCE

    @balance += value
  end

  def touch_in station
    deduct(@penalty_fare) if in_journey?
    raise "Please top up before travelling" if @balance < @min_fare

    @history.unshift(@journey_class.new)
    @history[0].start(station)
  end

  def touch_out(exit_station)
    return deduct(@penalty_fare) unless in_journey?

    deduct(@min_fare)
    @history[0].finish exit_station
  end

  def in_journey?
    return false if @history.empty?

    !@history[0].complete?
  end

  def entry_station
    return nil if @history[0].complete?

    @history[0].entry if in_journey?
  end

  private
  # attr_reader :in_journey
  def deduct(fare)
    @balance -= fare
  end

end
