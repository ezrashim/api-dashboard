require 'spec_helper'

feature "news", vcr: true do
  scenario 'user sees their current top stories' do
    visit '/'

    expect(page).to have_content("Today's Top Stories")
    expect(page).to have_content(/http:\/\/www.nytimes.com/)
  end
end
