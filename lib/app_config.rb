module AppConfig

  require 'yaml'
  load 'settings.rb'
  include Settings
  here = File.dirname(__FILE__)
  CONF_FILE = [here + '/../config/.env_conf.yml', here + '/../config/.env_conf.yml.example']

  def self.load_app_settings
    if File.readable?(CONF_FILE.first)
      settings_location = CONF_FILE.first
    else
      settings_location = CONF_FILE.last
    end
    Kernel.const_set(:EnvSettings, Settings.deep_open_struct(YAML.load_file(settings_location)))
  end

  module CourseConstants

    def self.course
      base_struct.api.course
    end

    def self.api_key
      base_struct.api.api_key
    end

    def self.base_url
      base_struct.api.server
    end

    def self.lti_key
      base_struct.app.lti_key
    end

    def self.lti_secret
      base_struct.app.lti_secret
    end

    def self.app_secret
      base_struct.app.secret_key_base
    end

    def self.lti_base_url
      base_struct.app.lti_base_url
    end

    private

    ## ENV['RAILS_ENV'] works in Thor, not in the server
    ## ::Rails.env works in the server, not in Thor
    def self.rails_env
      ENV['RAILS_ENV'] || ::Rails.env
    end

    def self.base_struct
      EnvSettings.send(self.rails_env)
    end

   end

end
