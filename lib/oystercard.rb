class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(value)
    fail "top up over max balance" if @balance + value > MAX_BALANCE
    @balance += value
  end
end
