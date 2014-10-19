class PreviewJob
  include SuckerPunch::Job

  def perform(origin, destination, tarball, card)
    destination.destroy
    origin.fork_into(destination)
    destination.deploy_branch(tarball)
    destination.run_command("rake db:migrate")

    card.update_attributes(preview_url: destination.url)
  end
end
