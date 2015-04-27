Rails.application.config.middleware.use OmniAuth::Builder do
  ENV["GITHUB_KEY"] ||= "03fafb19e89f60f1f0f3"
  ENV["GITHUB_SECRET"] ||= "2fd993d61ff8eefa127ee5eee0507bdfa5312c44"

  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"],
           scope: "user,repo"
end

unless Rails.env.production? || Rails.env.test?
  OmniAuth::Strategies::OAuth2.class_eval do
    def callback_url
      Forwarder::URLHelpers.forward_url
    end
  end
end
