require 'station'

describe Station do
  subject(:station) { Station.new "Aldegate", 1 }

  describe "#initialise" do
    it "has a name" do
      expect(station.name).to eq "Aldegate"
    end

    it "has a zone" do
      expect(station.zone).to eq 1
    end
  end
end
