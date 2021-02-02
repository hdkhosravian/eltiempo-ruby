require './lib/src/services/result'

describe Lib::Src::Services::Details do
  context "success requests" do
    it "for max avg" do
      # we have to fake date for our test because we are using mock data
      allow(Time).to receive(:now).and_return(Time.parse('2021-02-02'))

      mock_requests

      list = Lib::Src::Services::List.new.process
      local_id = Lib::Src::Services::Find.new(list[:object], 'Gavamar').process
      temp = Lib::Src::Services::Show.new(local_id[:object]).process
      result = Lib::Src::Services::Details.new(temp[:object], 'max').process

      expect(result[:object]).to eq(16.71)
      expect(result[:errors]).to eq([]) 
    end

    it "for min avg" do
      # we have to fake date for our test because we are using mock data
      allow(Time).to receive(:now).and_return(Time.parse('2021-02-02'))

      mock_requests

      list = Lib::Src::Services::List.new.process
      local_id = Lib::Src::Services::Find.new(list[:object], 'Gavamar').process
      temp = Lib::Src::Services::Show.new(local_id[:object]).process
      result = Lib::Src::Services::Details.new(temp[:object], 'min').process

      expect(result[:object]).to eq(8.43)
      expect(result[:errors]).to eq([]) 
    end

    it "for today temp" do
      # we have to fake date for our test because we are using mock data
      allow(Time).to receive(:now).and_return(Time.parse('2021-02-02'))

      mock_requests

      list = Lib::Src::Services::List.new.process
      local_id = Lib::Src::Services::Find.new(list[:object], 'Gavamar').process
      temp = Lib::Src::Services::Show.new(local_id[:object]).process
      result = Lib::Src::Services::Details.new(temp[:object], 'today').process

      expect(result[:object]).to eq("min: 9\nmax: 18")
      expect(result[:errors]).to eq([]) 
    end
  end

  it "call wrong type" do
    mock_requests

    list = Lib::Src::Services::List.new.process
    local_id = Lib::Src::Services::Find.new(list[:object], 'Gavamar').process
    temp = Lib::Src::Services::Show.new(local_id[:object]).process

    expect {
      Lib::Src::Services::Details.new(temp[:object], 'wrong_type').process
    }.to raise_error(NoMethodError)
  end
end
