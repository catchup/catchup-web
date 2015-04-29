module Forwarder
  module URLHelpers
    def self.forward_url
      "#{root_url}/forward"
    end

    def self.store_redirect_url
      "#{root_url}/forward/store_redirect"
    end

    def self.root_url
      url = ENV.fetch("FORWARDER_ROOT_URL", "http://catchup.io")
      url.chop! if url.end_with?("/")
      url
    end
  end
end
