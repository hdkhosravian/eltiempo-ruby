module MockRequest
  def mock_requests
    stub_request(:get, "#{ENV["TIEMPO_URL"]}?api_lang=#{ENV["API_LANG"]}&division=#{ENV["DEVISION"]}&affiliate_id=#{ENV["AFFILIATE_ID"]}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/index.xml"), headers: {"Content-Type"=> "text/xml"})

    stub_request(:get, "#{ENV["TIEMPO_URL"]}?api_lang=#{ENV["API_LANG"]}&localidad=1381&affiliate_id=#{ENV["AFFILIATE_ID"]}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/details.xml"), headers: {"Content-Type"=> "text/xml"})
  end
end
