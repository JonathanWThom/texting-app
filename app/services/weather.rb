class Weather

  def initialize(zip, city)
    @zip = zip
    @city = city
  end

  def get_weather
    begin
      response = RestClient::Request.new(
        :method => :get,
        :url => "api.openweathermap.org/data/2.5/forecast?zip=" + @zip.to_s + ",us&APPID=" + ENV['WEATHER_API_KEY'],
      ).execute
      parsed_response = JSON.parse(response)
      time = Time.at(parsed_response['list'][0]['dt']).to_datetime.strftime("%I:%M%p") ## 10 am
      kelvin = parsed_response['list'][0]['main']['temp']
      temp = (9/5 * (kelvin - 273) + 32).round(1)
      conditions = parsed_response['list'][0]['weather'][0]['description']

      text_response = "#{@city} will be #{temp} degrees at #{time}. There will be: #{conditions}."
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      throw(:abort)
    end
  end

  def get_long_weather
    begin
      response = RestClient::Request.new(
        :method => :get,
        :url => "api.openweathermap.org/data/2.5/forecast?zip=" + @zip.to_s + ",us&APPID=" + ENV['WEATHER_API_KEY'],
      ).execute
        @i = 0
        @text_response = "Here's the weather forecast for #{@city}: \n"
        while @i < 5
          parsed_response = JSON.parse(response)
          time = Time.at(parsed_response['list'][@i]['dt']).to_datetime.strftime("%I:%M%p") ## 10 am
          kelvin = parsed_response['list'][@i]['main']['temp']
          temp = (9/5 * (kelvin - 273) + 32).round(1)
          conditions = parsed_response['list'][@i]['weather'][0]['description']
          @text_response += "It will be #{temp} degrees at #{time}. There will be: #{conditions}. \n"
          @i += 1
        end
        @text_response
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      throw(:abort)
    end
  end
end
