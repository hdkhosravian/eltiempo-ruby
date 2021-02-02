require './lib/src/services/result'

describe Lib::Src::Services::Result do
  context "success requests" do
    it "for max avg temp" do
      # we have to fake date for our test because we are using mock data
      allow(Time).to receive(:now).and_return(Time.parse('2021-02-02'))

      mock_requests
      result = Lib::Src::Services::Result.new('Gavamar', 'max').process
      expect(result[:object]).to eq(16.71) 
      expect(result[:errors]).to eq([]) 
    end

    it "for min avg temp" do
      # we have to fake date for our test because we are using mock data
      allow(Time).to receive(:now).and_return(Time.parse('2021-02-02'))

      mock_requests
      result = Lib::Src::Services::Result.new('Gavamar', 'min').process
      expect(result[:object]).to eq(8.43)
      expect(result[:errors]).to eq([]) 
    end

    it "for today temp" do
      # we have to fake date for our test because we are using mock data
      allow(Time).to receive(:now).and_return(Time.parse('2021-02-02'))

      mock_requests
      result = Lib::Src::Services::Result.new('Gavamar', 'today').process
      expect(result[:object]).to eq("min: 9\nmax: 18") 
      expect(result[:errors]).to eq([]) 
    end
  end

  context "similar cities" do
    it "for max avg temp" do
      mock_requests
      result = Lib::Src::Services::Result.new('Gav', 'max').process
      expect(result[:object]).to eq("")
      expect(result[:errors]).to include("we could not find the Gav, did you mean:\nGavà\nGavamar") 
    end

    it "for min avg temp" do
      mock_requests
      result = Lib::Src::Services::Result.new('Gav', 'min').process
      expect(result[:object]).to eq("")
      expect(result[:errors]).to include("we could not find the Gav, did you mean:\nGavà\nGavamar") 
    end

    it "for today temp" do
      mock_requests
      result = Lib::Src::Services::Result.new('Gav', 'today').process
      expect(result[:object]).to eq("")
      expect(result[:errors]).to include("we could not find the Gav, did you mean:\nGavà\nGavamar") 
    end
  end

  context "wrong city name" do
    it "for max avg temp" do
      mock_requests
      result = Lib::Src::Services::Result.new('test', 'max').process
      expect(result[:object]).to eq("")
      expect(result[:errors]).to include("we could not find the test") 
    end

    it "for min avg temp" do
      mock_requests
      result = Lib::Src::Services::Result.new('test', 'min').process
      expect(result[:object]).to eq("")
      expect(result[:errors]).to include("we could not find the test") 
    end

    it "for today temp" do
      mock_requests
      result = Lib::Src::Services::Result.new('test', 'today').process
      expect(result[:object]).to eq("")
      expect(result[:errors]).to include("we could not find the test") 
    end
  end
end
