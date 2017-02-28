class Weather

  def initialize(zip)
    @zip = zip
  end

  def get_weather
    begin
      response = RestClient::Request.new(
        :method => :get,
        :url => "api.openweathermap.org/data/2.5/forecast?zip=" + @zip.to_s + ",us&APPID=" + ENV['WEATHER_API_KEY'],
      ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      throw(:abort)
    end
    parsed_response = JSON.parse(response)
    time = Time.at(parsed_response['list'][0]['dt']).to_datetime.strftime("%I:%M%p") ## 10 am
    kelvin = parsed_response['list'][0]['main']['temp']
    temp = (9/5 * (kelvin - 273) + 32).round(1)
    conditions = parsed_response['list'][0]['weather'][0]['description']
    text_response = "The zip code #{@zip} will be #{temp} degrees at #{time}. The conditions will be: #{conditions}."
  end
end
