class Slapi
  class Authentication
    def initialize(base_url)
      @base_url = base_url
      @access_token = ""
      @client_id = ""
      @client_secret = ""
    end

    def authenticate!(client_id, client_secret)
      client_id = client_id
      client_secret = client_secret

      unless client_id || client_secret
        raise ArgumentError, "client_id and client_secret are required"
      end

      credential = Base64.strict_encode64("#{client_id}:#{client_secret}")
      url = URI.parse("#{@base_url}/oauth/token") # CHECK: ここって共通？
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request_header = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "Basic #{credential}"
      }

      request = Net::HTTP::Post.new(url.path, request_header)
      request.body = "grant_type=client_credentials"
      response = https.request(request)
      response_body = JSON.parse(response.body)

      @access_token = response_body['access_token']
    end

    def access_token
      @access_token
    end
  end
end