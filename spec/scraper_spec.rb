require 'spec_helper'

describe 'Scraper' do

  let!(:dummy_event_hash){{
    title: 'Coding for everyone',
    organiser: 'Founders & Coders',
    address: '14 Palmers Road, E2 0SY, London',
    date: 'Monday, July 31, 2017',
    time: '6:30 PM to 8:00 PM'
  }}

  describe '#fetch_meetup_list' do
    it 'is a class method that executes a search on the meetup.com home page and scrapes the resulting page, returning an array of event hashes' do
      url = './fixtures/meetup/index.html'
      scraped_events = Scraper.fetch_meetup_list(url)
      expect(scraped_events).to be_a(Array)
      #expect(scraped_events.first).to have_key(:count)
      expect(scraped_events.first).to have_key(:title)
      expect(scraped_events.first).to have_key(:organiser)
      expect(scraped_events.first).to have_key(:url)
      expect(scraped_events.first).to have_key(:location)
      expect(scraped_events.first).to have_key(:num_attending)
      expect(scraped_events.first).to have_key(:time)
      expect(scraped_events.first).to have_key(:date)
    end
  end

  describe '#fetch_event_details' do
    it 'is a class method that scrapes the event\'s description page, returning a hash of attributes describing an individual event' do
      event_url = './fixtures/meetup/event.html'
      event_hash = Scraper.fetch_event_details(event_url)
      expect(event_hash).to be_a(Hash)
      # expect(event_hash).to match(dummy_event_hash)
    end
  end

end
