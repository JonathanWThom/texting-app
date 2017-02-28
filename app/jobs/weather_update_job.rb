class WeatherUpdateJob < ApplicationJob


  def perform
    weather = Weather.new('97232', 'Portland')
    forecast = weather.get_long_weather
    boot_twilio
    sms = @client.messages.create(
    from: Rails.application.secrets.twilio_number,
    to: ENV['SAMPLE_RECEIVER_PHONE_NUMBER'],
    body: forecast
    )
  end

  def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
  end
end
