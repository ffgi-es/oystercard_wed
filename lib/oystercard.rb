class Oystercard

  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(value)
    fail "top up over max balance" if @balance + value > MAX_BALANCE
    @balance += value
  end

  def touch_in station
    fail "Please top up before travelling" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private
  # attr_reader :in_journey
  def deduct(fare)
    @balance -= fare
  end

end
