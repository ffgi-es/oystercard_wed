require './lib/oystercard.rb'

describe Oystercard do
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }
  let(:journey) { double(:journey, start: nil, finish: nil) }
  let(:journey_class) { double(:Journey, new: journey) }
  let(:min_fare) { 1 }
  let(:penalty_fare) { 6 }

  subject{ Oystercard.new(journey_class, min_fare, penalty_fare) }

  describe "#initialize" do
    it "the balance should be 0 as default" do
      expect(subject.balance).to eq 0
    end

    it "should have an empty history by default" do
      expect(subject.history).to eq []
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

    before :each do
      allow(journey).to receive(:complete?).and_return(false)
    end

    it "raises an error if balance at touch_in is below minimum fare" do
      expect { subject.touch_in station }.to raise_error ("Please top up before travelling")
    end

    context "topped up" do

      before :each do
        subject.top_up(Oystercard::MAX_BALANCE)
      end

      it "starts a journey when touching in" do
        subject.touch_in station
        expect(subject.in_journey?).to eq true
      end

      it "should start the journey" do
        expect(journey).to receive(:start)
        subject.touch_in(station)
      end

      it "records entry station" do
        allow(journey).to receive(:entry).and_return(station)
        subject.touch_in station
        expect(subject.entry_station).to eq station
      end

      it "should enforce penalty fare" do
        subject.touch_in(station)
        expect { subject.touch_in(station) }.to change { subject.balance }.by(-penalty_fare)
      end
    end
  end

  describe "#touch_out" do
    it "should enforce penalty fare" do
      expect { subject.touch_out(station2) }.to change { subject.balance }.by(-penalty_fare)
    end

    context "on a journey" do
      before :each do
        subject.top_up(10)
        subject.touch_in station
        allow(journey).to receive(:complete?).and_return(false)
      end

      it "should deduct the minimum fare from the balance" do
        expect { subject.touch_out(station2) }.to change { subject.balance }.by(-min_fare)
      end

      it "should set in_journey to false" do
        subject.touch_out(station2)
        allow(journey).to receive(:complete?).and_return(true)
        expect(subject.in_journey?).to eq false
      end

      it "should erase the entry station upon touch_out" do
        subject.touch_out(station2)
        allow(journey).to receive(:complete?).and_return(true)
        expect(subject.entry_station).to eq nil
      end

      it "should add the journey to the history" do
        subject.touch_out(station2)
        expect(subject.history).to eq [journey]
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
