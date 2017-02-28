require 'rails_helper'

describe 'the message path', :vcr => true do
  it 'will generate a new message' do
    visit new_message_path
    within("#to") do
      fill_in 'to_', :with => ENV['SAMPLE_RECEIVER_PHONE_NUMBER']
    end
    fill_in "message_from", :with => ENV['SAMPLE_SENDER_PHONE_NUMBER']
    fill_in "message_body", :with => "Jenny, I got your number"
    click_on "Send"
    expect(page).to have_content("Jenny, I got your number")
    click_on "Jenny, I got your number"
    expect(page).to have_content('Message')
  end

  it 'will fail to generate a message' do
    visit new_message_path
    within("#to") do
      fill_in 'to_', :with => ENV['SAMPLE_RECEIVER_PHONE_NUMBER']
    end
    fill_in "message_from", :with => ENV['SAMPLE_SENDER_PHONE_NUMBER']
    click_on "Send"
    expect(page).to have_content('Something went wrong')
  end
end
