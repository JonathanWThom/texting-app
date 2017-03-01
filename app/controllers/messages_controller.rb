class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @contacts = Contact.all
  end

  def create
    @contacts = Contact.all
    ## there has GOT to be a better way to do this
    messages = 0
    saved_messages = []
    params[:to].each do |to|
      if to != ""
        messages += 1
        @message = Message.new(to: to, from: message_params[:from], body: message_params[:body])
        if @message.save
          saved_messages.push(@message)
        end
      end
    end

    if saved_messages.length == messages && saved_messages.length != 0
      flash[:notice] = "All messages sent"
      redirect_to messages_path
    else
      render :new
    end


    #cannot handle a totally empty form
  end

  def show
    @message = Message.find(params[:id])
  end

  def reply
    message = ReceivedMessage.new(params["Body"])
    binding.pry
    zip = message.get_zip
    city = message.get_city
    from_number = params["From"]
    if message.weather_check == true && message.long_forecast == true
      weather = Weather.new(zip, city)
      forecast = weather.get_long_weather
      boot_twilio
      sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: forecast
      )
    elsif message.weather_check == true
      weather = Weather.new(zip, city)
      forecast = weather.get_weather
      boot_twilio
      sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: forecast
      )
    else
      boot_twilio
      sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: "Enter a valid zip code and the word 'weather' to see get a forecast. Add the word 'long' to get an extended forecast."
      )
    end

  end

private

  def message_params
    params.require(:message).permit(:to, :from, :body)
  end

  def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
  end
end
