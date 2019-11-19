class Oystercard

  attr_reader :balance, :history
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(value)
    fail "top up over max balance" if @balance + value > MAX_BALANCE
    @balance += value
  end

  def touch_in station
    fail "Please top up before travelling" if @balance < MINIMUM_FARE
    @history.unshift({ entry: station })
  end

  def touch_out(exit_station)
    fail "unable to touch out" unless in_journey?
    deduct(MINIMUM_FARE)
    @history[0][:exit] = exit_station
  end

  def in_journey?
    return false if @history.empty?
    !@history[0][:entry].nil? && @history[0][:exit].nil?
  end

  def entry_station
    @history[0][:entry] if in_journey?
  end

  private
  # attr_reader :in_journey
  def deduct(fare)
    @balance -= fare
  end

end
