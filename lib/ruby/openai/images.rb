module OpenAI
  class Images
    include HTTParty
    base_uri "https://api.openai.com"

    def initialize(access_token: nil)
      @access_token = access_token || ENV.fetch("OPENAI_ACCESS_TOKEN")
    end
    
    def generate(version: default_version, parameters: {})
      post(url: "/#{version}/images/generations", parameters: parameters)
    end

    def post(url:, parameters:)
      self.class.post(
        url,
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@access_token}"
        },
        body: parameters.to_json
      )
    end
    
    def default_version
      "v1".freeze
    end
  end
end