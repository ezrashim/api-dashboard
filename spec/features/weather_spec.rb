require 'spec_helper'

feature "weather", vcr: true do
  scenario 'user sees their current local weather' do
    visit '/'

    expect(page).to have_content("Weather")
    expect(page).to have_content("F")
  end
end
