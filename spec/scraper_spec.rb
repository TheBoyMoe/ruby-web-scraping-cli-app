require 'spec_helper'

describe 'Scraper' do

  let!(:dummy_event_hash){{
    title: 'Coding for everyone',
    organiser: 'Founders & Coders',
    address: '14 Palmers Road, E2 0SY, London',
    date: 'Monday, July 31, 2017',
    time: '6:30 PM to 8:00 PM',
    description: "Come and join us for our regular Monday evening meetup and participate in any one of a number of peer-led JavaScript coding activities, including:  Free Code Camp projects  Solving and creating Codewars katas  Codecademy  Eloquent Javascript  CS50 This meetup is for everyone who wants to learn to code. During the meetup we encourage participants to work together with another meetup attendee on one laptop (pair programming). Students from the current cohort of Founders & Coders will be available for questions and support. Please note that laptops aren't provided, but since we encourage pair programming you are welcome to join us without a laptop and work with another participant. Founders and Coders, Code of Conduct: https://github.com/codingforeveryone/code-of-conduct Our community is dedicated to providing a harassment-free experience for everyone. We do not tolerate harassment of community members in any form. Participants violating these rules may be sanctioned or expelled from the event and any future events, as well as from the community itself. "
  }}

  describe '#fetch_meetup_list' do
    it 'is a class method that executes a search on the meetup.com home page and scrapes the resulting page, returning an array of event hashes' do
      url = './fixtures/meetup/index.html'
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

  describe '#fetch_event_details' do
    it 'is a class method that scrapes the event\'s description page, returning a hash of attributes describing an individual event' do
      event_url = './fixtures/meetup/event.html'
      event_hash = Scraper.fetch_event_details(event_url)
      expect(event_hash).to be_a(Hash)
      # expect(event_hash).to match(dummy_event_hash)
    end
  end

end
