require 'net/http'

module GroupMe
  KEY = "8bdcf4805aa001303adc22000a8f8683"

  def groups
    url = "https://api.groupme.com/v3/groups?token=#{KEY}"
    make_ssl_request(url)
  end

   #add params and key using something in net http
  def make_ssl_request(request_uri, params = {})
    request_uri = build_request_uri(request_uri, params)
    ap request_uri
    uri = URI.parse(request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
  end

  def make_request(request_uri, params = {})
    request_uri = build_request_uri(request_uri, params)
    ap request_uri
    uri = URI.parse(request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
  end
end
