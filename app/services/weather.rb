class Weather

  def initialize(zip)
    @zip = zip
  end

  def get_weather
    begin
      response = RestClient::Request.new(
        :method => :get,
        :url => "api.openweathermap.org/data/2.5/forecast?zip=" + @zip.to_s + ",us&APPID=" + "be10715616544f4607e99ff2d078bba7",
      ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      throw(:abort)
    end
  end
end
