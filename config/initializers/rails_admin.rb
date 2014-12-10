RailsAdmin.config do |config|
  config.authorize_with do
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV.fetch("ADMIN_USERNAME") &&
      password == ENV.fetch("ADMIN_PASSWORD")
    end
  end if Rails.env.production?

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
