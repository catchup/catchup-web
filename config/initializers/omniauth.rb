Rails.application.config.middleware.use OmniAuth::Builder do
  ENV["GITHUB_KEY"] ||= "03fafb19e89f60f1f0f3"
  ENV["GITHUB_SECRET"] ||= "2fd993d61ff8eefa127ee5eee0507bdfa5312c44"

  ENV["HEROKU_OAUTH_ID"] ||= "ffd3387b-7974-4aa5-887a-3c17cb2fe632"
  ENV["HEROKU_OAUTH_SECRET"] ||= "2fa9f54e-c9e6-4313-b6f5-329074e023dc"

  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"],
           scope: "user:email,public_repo",
           provider_ignores_state: true

  provider :heroku, ENV["HEROKU_OAUTH_ID"], ENV["HEROKU_OAUTH_SECRET"],
           scope: "global",
           provider_ignores_state: true
end

unless Rails.env.test?
  OmniAuth::Strategies::OAuth2.class_eval do
    def callback_url
      Forwarder::URLHelpers.forward_url
    end
  end
end
