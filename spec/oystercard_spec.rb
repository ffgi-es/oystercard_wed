require './lib/oystercard.rb'

describe Oystercard do
  let(:station) { double(:station) }

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

  describe "#touch_in" do
    it "starts a journey when touching in" do
      subject.top_up(10)
      subject.touch_in station
      expect(subject.in_journey?).to eq true
    end

    it "raises an error if balance at touch_in < #{Oystercard::MINIMUM_FARE}" do
      expect { subject.touch_in station }.to raise_error ("Please top up before travelling")
    end

    it "records entry station" do
      subject.top_up 10
      subject.touch_in station
      expect(subject.entry_station).to eq station
    end
  end

  describe "#touch_out" do
    it "finishes a journey when touching out" do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

    context "on a journey" do
      before :each do
        subject.top_up(10)
        subject.touch_in station
      end

      it "should deduct the minimum fare from the balance" do
        min = Oystercard::MINIMUM_FARE
        expect { subject.touch_out }.to change { subject.balance }.by(-min)
      end

      it "should set in_journey to false" do
        subject.touch_out
        expect(subject.in_journey?).to eq false
      end

      it "should erase the entry station upon touch_out" do
        subject.touch_out
        expect(subject.entry_station).to eq nil
      end

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
