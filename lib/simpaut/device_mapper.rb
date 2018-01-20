require 'yaml'

class DeviceMapper
  GLOBAL_CONFIG_PATH = '/etc/simpaut/settings.yml'

  def self.find_by_name(name, logger)
    path = File.exists?(GLOBAL_CONFIG_PATH) ? GLOBAL_CONFIG_PATH : 'config/settings.yml'
    @devices ||= YAML.load_file(path)['devices']
    attrs = @devices[name.to_s]
    attrs[:logger] = logger
    SamsungWamApi::Device.new(attrs.symbolize_keys)
  end
end
