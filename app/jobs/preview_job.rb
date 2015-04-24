class PreviewJob
  include SuckerPunch::Job

  def perform(user, origin, destination, tarball, card)
    destination.destroy
    origin.fork_into(destination)
    destination.deploy_branch(tarball)
    destination.run_command("rake db:migrate")

    card.previewed!(destination.url)
    CardObserver.publish(:card_previewed, card, user, card.preview_url)
  end
end
