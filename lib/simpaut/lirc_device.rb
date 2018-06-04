require 'shellwords'
require 'simpaut/device'

class LircDevice < Device
  def initialize(remote_name:, on_key_name:, off_key_name:, **args)
    super(**args)
    @remote_name = remote_name
    @on_key = on_key_name
    @off_key = off_key_name
  end

  def on!
    command!(@on_key)
  end

  def off!
    command!(@off_key)
  end

  def command!(cmd)
    command = "irsend send_once #{Shellwords.escape(@remote_name)} #{Shellwords.escape(cmd)}"
    @logger.debug "executing irsend command: #{command}"
    stdout = `#{command}`
    if $?.success?
      @logger.debug 'execution successful'
    else
      @logger.error "execution failed, stdout follows\n#{stdout}"
    end
  end
end
