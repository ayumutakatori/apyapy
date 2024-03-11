module Slapi
  class Client
    def initialize(base_url, access_token = nil)
      @base_url = base_url
      @access_token = access_token
      @authentication = Slapi::Authentication.new(@base_url)
      @content_type = 'application/x-www-form-urlencoded'
      @request_header = {
        'Authorization' => "Bearer #{@access_token}",
        'Content-Type' => @content_type,
        'Accept' => 'application/json',
      }
      url = URI.parse("#{@base_url}")
      @https = Net::HTTP.new(url.host, url.port)
      @https.use_ssl = true
    end

    def authenticate!(client_id, client_secret)
      @authentication.authenticate!(client_id, client_secret)
      @access_token = @authentication.access_token
      @request_header = {
        'Authorization' => "Bearer #{@access_token}",
        'Content-Type' => 'x-www-form-urlencoded',
        'Accept' => 'application/json',
      }
    end

    def get(path, params = "")
      url = URI.parse("#{@base_url}/#{path}?#{params}")
      response = @https.get(url, @request_header)
      JSON.parse(response.body)
    end

    def post(path, params = "")
      # TODO 実装
    end
  end
end