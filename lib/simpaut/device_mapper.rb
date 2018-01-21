class DeviceMapper
  def self.find_by_name(name, logger)
    attrs = Configuration.devices[name.to_s]
    attrs[:logger] = logger
    SamsungWamApi::Device.new(attrs.symbolize_keys)
  end
end
