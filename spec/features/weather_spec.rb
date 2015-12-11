require 'spec_helper'

feature "weather", vcr: true do
  let(:geolocation) { Geolocation.new("127.0.0.1") }
  let(:weather)  {Weather.new("127.0.0.1")}

  scenario 'user sees their current local weather' do
    visit '/'

    expect(page).to have_content("Weather")
    expect(page).to have_content(/\d+\.\d F \(\d+\.\d C\)/)
  end
end
