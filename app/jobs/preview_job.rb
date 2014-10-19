class PreviewJob
  include SuckerPunch::Job

  def perform(origin, destination, tarball)
    destination.destroy
    origin.fork_into(destination)
    destination.deploy_branch(tarball)
    destination.run_command("rake db:migrate")

    # TODO: set the destination url into the card
  end
end
