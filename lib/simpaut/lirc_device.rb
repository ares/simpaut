require 'shellwords'

class LircDevice
  def initialize(remote_name:, on_key_name:, off_key_name:, logger: Logger.new(STDOUT))
    @remote_name = remote_name
    @on_key = on_key_name
    @off_key = off_key_name
    @logger = logger
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