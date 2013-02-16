require 'net/http'

module GroupMe
  def self.key
    config_file = Rails.root.join 'config', 'api.yml'
    yml = YAML.load_file(config_file)
    return yml['key']
  end

  def self.groups
    url = "https://api.groupme.com/v3/groups"
    make_ssl_request(url)
  end

   #add params and key using something in net http
  def self.make_ssl_request(request_uri, params = {})
    request_uri = build_request_uri(request_uri, params)
    ap request_uri
    uri = URI.parse(request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
  end

  def self.make_request(request_uri, params = {})
    request_uri = build_request_uri(request_uri, params)
    ap request_uri
    uri = URI.parse(request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
  end

  private
  def self.build_request_uri(uri, params = {})
    params.delete_if { |k, v| v.blank? }
    params.merge!({ token: key })
    params = params.collect { |key, value| "#{key.to_s}=#{value}" }.join('&')
    uri + '?' + params
  end
end
