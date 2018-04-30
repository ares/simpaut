class DeviceMapper
  def self.find_by_name(name, logger)
    attrs = Configuration.devices[name.to_s]
    attrs = attrs.symbolize_keys
    attrs[:logger] = logger
    case attrs.delete(:type)
    when 'samsung_wam'
      SamsungWamApi::Device.new(attrs)
    when 'lirc_device'
      LircDevice.new(attrs)
    when 'local_device'
      LocalDevice.new(attrs)
    else
      raise 'Unknown device type'
    end
  end
end
