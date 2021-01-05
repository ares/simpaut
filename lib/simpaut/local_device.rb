require 'shellwords'
require 'simpaut/device'

class LocalDevice < Device
  def initialize(on_command:, off_command:, status_command: nil, env: '', **args)
    super(**args)
    @on_command = on_command
    @off_command = off_command
    @status_command = status_command
    @env = env
  end

  def on!
    command!(@on_command) if video_content? || unknown_content?
  end

  def off!
    command!(@off_command)
  end

  def on?
    power_status == 1
  end

  def off?
    power_status == 0
  end

  def power_status
    return 'unsupported' if @status_command.nil?

    command(@status_command) ? 1 : 0 
  end

  def command(cmd)
    command = "#{@env} #{cmd}"
    @logger.debug "executing shell: #{command}"
    `#{command}`
    $?.success?
  end

  def command!(cmd)
    command = "#{@env} #{cmd}"
    @logger.debug "executing shell: #{command}"
    stdout = `#{command}`
    if $?.success?
      @logger.debug 'execution successful'
    else
      @logger.error "execution failed, stdout follows\n#{stdout}"
    end
    $?.success?
  end
end
