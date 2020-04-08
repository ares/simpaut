require 'sinatra'
require 'samsung_wam_api'
require 'simpaut/configuration'
require 'simpaut/samsung_wam_device'
require 'simpaut/lirc_device'
require 'simpaut/local_device'
require 'simpaut/device_mapper'

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

get '/:device/kodi_on' do
  load_device
  @device.kodi_on! if @device.respond_to?(:kodi_on!)
  response
end

get '/:device/off' do
  load_device
  @device.off! if !@device.respond_to?(:power_status) || !@device.off?
  response
end

get '/:device/kodi_off' do
  load_device
  @device.kodi_off! if @device.respond_to?(:kodi_off!)
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

get '/:device/volume' do
  load_device
  return unsupported unless @device.respond_to?(:volume)

  @device.volume.to_s
end

get '/:device/set_volume/:volume' do
  load_device
  return unsupported unless @device.respond_to?(:set_volume)

  @device.set_volume(params[:volume])
  response
end

get '/:device/status' do
  load_device
  return unsupported unless @device.respond_to?(:power_status)

  @device.power_status.to_s
end

get '/:device/input' do
  load_device
  return unsupported unless @device.respond_to?(:input)

  @device.input
end

get '/:device/set_input/:input' do
  load_device
  return unsupported unless @device.respond_to?(:set_input!)

  @device.set_input!(params[:input])
end

get '/:device/audio_info' do
  load_device
  return unsupported unless @device.respond_to?(:audio_info)

  @device.audio_info
end

get '/:device/cloud_username' do
  load_device
  return unsupported unless @device.respond_to?(:cloud_username)

  @device.cloud_username
end

get '/:device/play_info' do
  load_device
  return unsupported unless @device.respond_to?(:play_info)

  @device.play_info
end

get '/:device/cloud_provider_info' do
  load_device
  return unsupported unless @device.respond_to?(:cloud_provider_info)

  @device.cloud_provider_info
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
