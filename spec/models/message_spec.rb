require 'rails_helper'

describe Message, :vcr => true do

  ## testing for sending message?
  
  it 'adds an error if the to number is invalid' do
    message = Message.new(:body => 'hi', :to => '1111111', :from => '3604615580')
    message.save
    expect(message.errors.messages[:base]).to eq(["The 'To' number 1111111 is not a valid phone number."])
  end
end
