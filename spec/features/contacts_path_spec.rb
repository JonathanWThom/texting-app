require 'rails_helper'

describe 'the contacts path' do
  it 'will add a new contact' do
    visit new_contact_path
    fill_in 'Name', :with => 'Jenny'
    fill_in 'Number', :with => '3608675309'
    click_on 'Create Contact'
    expect(page).to have_content('Jenny')
  end

  it 'will fail to add a new contact' do
    visit new_contact_path
    click_on 'Create Contact'
    expect(page).to have_content('Something went wrong')
  end

  it 'will visit contact\'s page' do
    contact = create(:contact)
    visit contact_path(contact)
  end
end
