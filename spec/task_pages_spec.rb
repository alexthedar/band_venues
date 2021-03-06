require('spec_helper')
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

require('spec_helper')
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'deleting a band path', :type => :feature do
  it 'allows user to delete a band' do
    alex_caste = Band.create({band_name: "Alex Caste"})
    visit '/'
    click_button "delete_band"
    expect(page).to have_content("")
  end
end

describe 'deleting a venue path', :type => :feature do
  it 'allows user to delete a venue' do
    black_rock_desert = Venue.create({venue_name: "Black Rock Desert"})
    visit '/'
    click_button "delete_venue"
    expect(page).to have_content("")
  end
end

describe 'adding a venue to a band', :type => :feature do
  it 'allows user to add a venue to a band' do
    john_digweed = Band.create({band_name: "John Digweed"})
    black_rock_desert = Venue.create({venue_name: "Black Rock Desert"})
    visit '/'
    click_link 'John Digweed'
    check 'Black Rock Desert'
    click_button 'Add'
    expect(page).to have_content("is currently booked at")
  end
end

describe 'deleting a venue from a band', :type => :feature do
  it 'allows user to delete a venue to a band' do
    john_digweed = Band.create({band_name: "John Digweed"})
    black_rock_desert = Venue.create({venue_name: "Black Rock Desert"})
    john_digweed.venues.push(black_rock_desert)
    visit '/'
    click_link 'John Digweed'
    click_button 'remove_venue'
    expect(page).to have_content("This artist is not currently booked")
  end
end

describe 'add new venue to band', :type => :feature do
  it 'allows user to add a completely new venue and auto assign to band' do
    john_digweed = Band.create({band_name: "John Digweed"})
    visit '/'
    click_link 'John Digweed'
    fill_in 'Venue Name', with: 'The Mighty'
    click_button 'add_venue'
    expect(page).to have_content('The Mighty')
  end
end

describe 'edit band name', :type => :feature do
  it 'allows user to edit band name' do
    john_digweed = Band.create({band_name: "John Digweed"})
    visit '/'
    click_link 'John Digweed'
    fill_in 'edit_name', with: 'Markus Schulz'
    click_button 'edit_name'
    expect(page).to have_content('Markus Schulz')
  end
end
