require 'spec_helper'

describe 'Scraper' do

  describe '#fetch_meetup_list' do
    it 'is a class method that executes a search on the meetup.com home page and scrapes the resulting page, returning an array of event hashes' do
      url = './fixtures/meetup/test.html'
      scraped_events = Scraper.fetch_meetup_list(url)
      expect(scraped_events).to be_a(Array)
      expect(scraped_events.first).to have_key(:count)
      expect(scraped_events.first).to have_key(:title)
      expect(scraped_events.first).to have_key(:organiser)
      expect(scraped_events.first).to have_key(:url)
      expect(scraped_events.first).to have_key(:num_attending)
      expect(scraped_events.first).to have_key(:time)
      expect(scraped_events.first).to have_key(:date)
    end
  end

end
