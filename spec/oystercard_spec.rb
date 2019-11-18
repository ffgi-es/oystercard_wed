require './lib/oystercard.rb'

describe Oystercard do

  describe "#initialize" do
    it "the balance should be 0 as default" do
      expect(subject.balance).to eq 0
    end
  end
  describe "#top_up" do
    it "it increases the balance by 10 when added top through arguement of top_up" do
      expect(subject.top_up(10)).to eq 10
    end

    it "raises an error when top up increases balance over 90 pounds" do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up 1 }.to raise_error ("top up over max balance")
    end
  end

  describe "#deduct" do
    it "reduces the balance by 3 after topping up 10" do
      subject.top_up(10)
      expect { subject.deduct(3) }.to change {subject.balance}.by -3
    end
  end


  describe "#touch_in" do
    it "starts a journey when touching in" do
      expect(subject.touch_in).to eq true
    end
  end

  describe "#touch_out" do
    it "finishes a journey when touching out" do
      expect(subject.touch_out).to eq false
    end
  end

  describe "#in_journey?" do
    it "should initially not be in journey before touching in" do
      expect(subject.in_journey?).to eq false
    end
  end

end

#NameError
#./spec/oystercard_spec.rb
#1
#Oystercard class doesn't exist
#creating in the lib folder a file containg the class Oystercard
