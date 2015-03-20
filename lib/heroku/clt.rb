module Heroku
  class CLT
    def self.dry_run(api_key: "", cmd:, app: "", args: "")
      command = ""
      command += "HEROKU_API_KEY=#{api_key} " unless api_key.empty?
      command += "vendor/heroku-toolbelt/bin/heroku #{cmd}"
      command += " #{args}" unless args.empty?
      command += " --app #{app}" unless app.empty?

      command
    end

    def self.execute(*arguments)
      command = dry_run(*arguments)
      Rails.logger.info("Running command: #{command}")
      # Make sure we don't clutter environment with Bundler's stuff
      Bundler.with_clean_env { system(command) }
    end
  end
end
