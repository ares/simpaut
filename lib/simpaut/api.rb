require 'sinatra'
require 'samsung_wam_api'
require 'simpaut/device_mapper'

get '/' do
  "Hello from Simpaut #{Simpaut::VERSION}"
end

get '/:device/on' do
  load_device
  @device.on! unless @device.on?
  response
end

get '/:device/off' do
  load_device
  @device.off! unless @device.off?
  response
end

get '/:device/volume_up' do
  load_device
  @device.increase_volume if @device.on?
  response
end

get '/:device/volume_down' do
  load_device
  @device.decrease_volume if @device.on?
  response
end

def load_device
  @device = DeviceMapper.find_by_name(params[:device], logger)
end

def response
  'ok'
end
