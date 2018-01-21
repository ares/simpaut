require 'yaml'

class Configuration
  GLOBAL_CONFIG_PATH = '/etc/simpaut/settings.yml'

  def self.configuration
    @configuration ||= begin
      path = File.exists?(GLOBAL_CONFIG_PATH) ? GLOBAL_CONFIG_PATH : 'config/settings.yml'
      YAML.load_file(path)
    end
  end

  def self.authentication
    self.configuration['authentication']
  end

  def self.devices
    self.configuration['devices']
  end
end
