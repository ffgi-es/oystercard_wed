class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "top up over max balance" if @balance + value > MAX_BALANCE
    @balance += value
  end

  def touch_in
    fail "Please top up before travelling" if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_journey
  end

  private
  # attr_reader :in_journey
  def deduct(fare)
    @balance -= fare
  end

end
