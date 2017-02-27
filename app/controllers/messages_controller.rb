class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @contacts = Contact.all
  end

  def create
    messages = []
    params[:to].each do |to|
      if to != ""
        @message = Message.new(to: to, from: message_params[:from], body: message_params[:body])
        if @message.save
          flash[:notice] = "Message was saved"
          redirect_to messages_path
        else
          render :new
        end
      end
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
