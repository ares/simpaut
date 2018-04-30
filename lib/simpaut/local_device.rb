require 'shellwords'

class LocalDevice
  def initialize(on_command:, off_command:, logger: Logger.new(STDOUT), env: '')
    @on_command = on_command
    @off_command = off_command
    @env = env
    @logger = logger
  end

  def on!
    command!(@on_command)
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
