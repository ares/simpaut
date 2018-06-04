require 'shellwords'
require 'simpaut/device'

class LocalDevice < Device
  def initialize(on_command:, off_command:, env: '', **args)
    super(**args)
    @on_command = on_command
    @off_command = off_command
    @env = env
  end

  def on!
    command!(@on_command) if video_content? || unknown_content?
  end

  def off!
    command!(@off_command)
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
  end
end
