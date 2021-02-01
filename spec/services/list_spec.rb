require './lib/src/services/result'

describe Lib::Src::Services::List do
  it "success requests" do
    mock_requests
    result = Lib::Src::Services::List.new.process

    expect(result[:object].class).to eq(Nokogiri::XML::Document) 
    expect(result[:object].search('report location data').empty?).to eq(false) 
    expect(result[:errors]).to eq([]) 
  end

  it "wrong affiliate_id" do
    mock_requests

    affiliate_id = ENV["AFFILIATE_ID"]
    ENV["AFFILIATE_ID"] = 'AFFILIATE_ID'

    result = Lib::Src::Services::List.new.process
    ENV["AFFILIATE_ID"] = affiliate_id

    expect(result[:object]).to eq("")
    # please consider we are using es as our language and mock data base on that
    expect(result[:errors]).to include("Usted no está registrado como usuario de la API de tiempo.com o su cuenta no está activada.") 
  end
end
