class ReceivedMessage
  def initialize(body)
    @body = body
  end

  def weather_check
    @body.split.each do |word|
      if ZipCodes.identify(word)
        @valid_zip = true
      end
    end
    if (@body.downcase.split.include?('weather')) && (@valid_zip == true)
      true
    else
      false
    end
  end
end
