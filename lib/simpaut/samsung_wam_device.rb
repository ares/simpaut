class SamsungWamDevice < SamsungWamApi::Device
  def kodi_on!
    on! if off?
    set_input!('aux') unless input == 'aux'
  end

  def kodi_off!
    off! if on? && input == 'aux'
  end
end
