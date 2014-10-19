class PreviewsController
  def create
    # TODO: this whole process should happen in background. see SuckerPunch or
    #       sidekiq.

    # TODO: this should be random
    app_name    = "catchup-web-forks"

    # TODO: this should be set by the user somehow
    tarball     = "https://github.com/catchup/catchup-web/archive/whatever.tar.gz"

    origin      = Heroku::Application.from_name("catchup-web")
    destination = Heroku::Application.from_name(app_name)

    destination.destroy
    origin.fork_into(destination)
    destination.deploy_branch(tarball)
    destination.run_command("rake db:migrate")

    redirect_to destination.url
  end
end
