require 'yaml'

class DeviceMapper
  def self.find_by_name(name, logger)
    @devices ||= YAML.load_file('config/settings.yml')['devices']
    attrs = @devices[name.to_s]
    attrs[:logger] = logger
    SamsungWamApi::Device.new(attrs.symbolize_keys)
  end
end
