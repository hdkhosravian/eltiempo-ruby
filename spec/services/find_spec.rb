require './lib/src/services/result'

describe Lib::Src::Services::Find do
  it "success requests" do
    # we have to fake date for our test because we are using mock data
    allow(Time).to receive(:now).and_return(Time.parse('2021-02-02'))

    mock_requests
    list = Lib::Src::Services::List.new.process
    result = Lib::Src::Services::Find.new(list[:object], 'Gavamar').process

    expect(result[:object]).to eq('79215') 
    expect(result[:errors]).to eq([]) 
  end

  it "find similar cities" do
    # we have to fake date for our test because we are using mock data
    allow(Time).to receive(:now).and_return(Time.parse('2021-02-02'))

    mock_requests
    list = Lib::Src::Services::List.new.process
    result = Lib::Src::Services::Find.new(list[:object], 'Gav').process

    expect(result[:object]).to eq("")
    # please consider we can use I18N for our messages, but for this project I used english.
    expect(result[:errors]).to include("we could not find the Gav, did you mean:\nGavà\nGavamar") 
  end

  it "wrong city name" do
    mock_requests
    list = Lib::Src::Services::List.new.process
    result = Lib::Src::Services::Find.new(list[:object], 'test').process

    expect(result[:object]).to eq("")
    # please consider we can use I18N for our messages, but for this project I used english.
    expect(result[:errors]).to include("we could not find the test") 
  end
end
