require 'mopidy'
require 'simpaut/device'

class MopidyDevice < Device
  def initialize(alarm_sound_file:, mopidy_host:, **args)
    super(**args)
    @alarm_sound_file = alarm_sound_file
    @mopidy_host = mopidy_host
    Mopidy.configure do |config|
      config.mopidy_url = "http://#{@mopidy_host}:6680/mopidy/rpc"
    end
  end

  def alarm_on!
    Mopidy::Tracklist.clear
    Mopidy::Tracklist.add(uri: "file://#{@alarm_sound_file}")
    Mopidy::Tracklist.repeat = true
    Mopidy::Playback.play
  end

  def alarm_off!
    Mopidy::Playback.stop
    Mopidy::Tracklist.repeat = false
  end

  def volume 
    Mopidy::Mixer.volume.body
  end

  def set_volume(vol)
    Mopidy::Mixer.volume = vol.to_i
  end

  def increase_volume(step = 1)
    set_volume(volume + step.to_i)
  end

  def decrease_volume(step = 1)
    set_volume(volume - step.to_i)
  end
end
