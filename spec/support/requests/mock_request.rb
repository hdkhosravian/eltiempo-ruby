module MockRequest
  def mock_requests
    stub_request(:get, "#{ENV["TIEMPO_URL"]}?api_lang=#{ENV["API_LANG"]}&division=#{ENV["DEVISION"]}&affiliate_id=#{ENV["AFFILIATE_ID"]}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/index.xml"))

    stub_request(:get, "#{ENV["TIEMPO_URL"]}?api_lang=#{ENV["API_LANG"]}&localidad=79215&affiliate_id=#{ENV["AFFILIATE_ID"]}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/details.xml"))

    stub_request(:get, "#{ENV["TIEMPO_URL"]}?api_lang=#{ENV["API_LANG"]}&division=#{ENV["DEVISION"]}&affiliate_id=AFFILIATE_ID").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/affiliate_id.xml"))

    stub_request(:get, "#{ENV["TIEMPO_URL"]}?api_lang=#{ENV["API_LANG"]}&localidad=test&affiliate_id=#{ENV["AFFILIATE_ID"]}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/localidad.xml"))
  end
end
