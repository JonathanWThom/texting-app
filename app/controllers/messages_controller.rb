class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @contacts = Contact.all
  end

  def create
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

    if saved_messages.length == messages
      flash[:notice] = "All messages sent"
      redirect_to messages_path
    else
      render :new
    end
  end

  def show
    @message = Message.find(params[:id])
  end

private

  def message_params
    params.require(:message).permit(:to, :from, :body)
  end
end
