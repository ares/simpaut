class Device
  MOVIE = 'movie'
  AUDIO = 'music'
  SERIES = 'episode'
  MEDIA_TYPES = [ MOVIE, AUDIO, SERIES]

  def initialize(params: {}, logger: Logger.new(STDOUT))
    @params = params
    @logger = logger
    @logger.debug "Got following params for device: #{params.inspect}"
  end

  def audio_content?
    @params[:media_type] == AUDIO
  end

  def video_content?
    [MOVIE, SERIES].include?(@params[:media_type])
  end

  def unknown_content?
    !audio_content? && !video_content?
  end

  def logger
    @logger
  end

  def params
    @params
  end
end
