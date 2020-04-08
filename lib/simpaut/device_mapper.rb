class DeviceMapper
  def self.find_by_name(name, logger, params)
    attrs = Configuration.devices[name.to_s]
    attrs = attrs.symbolize_keys
    attrs[:logger] = logger
    case attrs.delete(:type)
    when 'samsung_wam'
      SamsungWamDevice.new(attrs)
    when 'lirc_device'
      LircDevice.new(attrs.merge(:params => params))
    when 'local_device'
      LocalDevice.new(attrs.merge(:params => params))
    else
      raise 'Unknown device type'
    end
  end
end
