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
end

#NameError
#./spec/oystercard_spec.rb
#1
#Oystercard class doesn't exist
#creating in the lib folder a file containg the class Oystercard
