require 'net/http'

module GroupMe
  def self.get_messages(group_id)
    url = "https://api.groupme.com/v3/groups/#{group_id}/messages"
    make_ssl_request(url)
  end

  def self.send_message(group_id, message)
    url = "https://api.groupme.com/v3/groups/#{group_id}/messages"
    opts = { action: "Post", body: message }
    make_ssl_request(url, opts)
  end

  def self.groups
    url = "https://api.groupme.com/v3/groups"
    make_ssl_request(url)
  end

  def self.key
    config_file = Rails.root.join 'config', 'api.yml'
    yml = YAML.load_file(config_file)
    return yml['key']
  end

  # add params and key using something in net http
  def self.make_ssl_request(request_uri, opts = {})
    request_uri = build_request_uri(request_uri, opts[:params] || {})
    uri = URI.parse(request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    case opts[:action]
    when "Get" || blank?
      request = Net::HTTP::Get.new(uri.request_uri)
    when "Post"
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = opts[:body].to_json
    end
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

  def self.image_message(image)
    {
      message: {
        text: image
      }
    }
  end

  private
  def self.build_request_uri(uri, params = {})
    params.delete_if { |k, v| v.blank? }
    params.merge!({ token: key })
    params = params.collect { |key, value| "#{key.to_s}=#{value}" }.join('&')
    uri + '?' + params
  end
end
