require './lib/oystercard.rb'

describe Oystercard do

  describe "#initialize" do
    it "the balance should be 0 as default" do
      expect(subject.balance).to eq 0
    end
  end

end

#NameError
#./spec/oystercard_spec.rb
#1
#Oystercard class doesn't exist
#creating in the lib folder a file containg the class Oystercard
