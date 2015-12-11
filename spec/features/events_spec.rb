require 'spec_helper'

feature "events", vcr: true do
  scenario 'user sees their current local events' do
    visit '/'

    expect(page).to have_content("Today's Events")
    expect(page).to have_content(/\w+ @ \w+ /)
  end
end
