require './lib/src/services/result'

describe Lib::Src::Services::Show do
  it "success requests" do
    mock_requests
    list = Lib::Src::Services::List.new.process
    local_id = Lib::Src::Services::Find.new(list[:object], 'Gavamar').process
    result = Lib::Src::Services::Show.new(local_id[:object]).process

    expect(result[:object].class).to eq(Nokogiri::XML::Document) 
    expect(result[:object].search('report location data').empty?).to eq(false) 
    expect(result[:errors]).to eq([]) 
  end

  it "wrong affiliate_id" do
    mock_requests
    result = Lib::Src::Services::Show.new('test').process

    expect(result[:object]).to eq("")
    # please consider we are using es as our language and mock data base on that
    expect(result[:errors]).to include("La localidad a la que intentas acceder no existe. Pruebe con otra localidad o póngase en contacto con el administrador del sistema (api@tiempo.com).") 
  end
end
