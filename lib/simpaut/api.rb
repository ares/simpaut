require 'sinatra'
require 'samsung_wam_api'
require 'simpaut/configuration'
require 'simpaut/device_mapper'
require 'simpaut/lirc_device'
require 'simpaut/local_device'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == Configuration.authentication['user'] and password == Configuration.authentication['password']
end

get '/' do
  "Hello from Simpaut #{Simpaut::VERSION}"
end

get '/:device/on' do
  load_device
  @device.on! if !@device.respond_to?(:power_status) || !@device.on?
  response
end

get '/:device/off' do
  load_device
  @device.off! if !@device.respond_to?(:power_status) || !@device.off?
  response
end

get '/:device/volume_up' do
  load_device
  return unsupported unless @device.respond_to?(:increase_volume)

  @device.increase_volume if @device.respond_to?(:power_status) && @device.on?
  response
end

get '/:device/volume_down' do
  load_device
  return unsupported unless @device.respond_to?(:decrease_volume)

  @device.decrease_volume if @device.respond_to?(:power_status) && @device.on?
  response
end

def load_device
  @device = DeviceMapper.find_by_name(params[:device], logger, params)
end

def response
  'ok'
end

def unsupported
  'unsupported'
end
