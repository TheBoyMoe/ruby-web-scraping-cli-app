require 'spec_helper'

describe 'Event' do

  let!(:event){MeetupScraper::Event.new.create_from_hash(
    title: 'Coding for everyone',
    organiser: 'Founders & Coders',
    date: '2017-07-31T23:30:00+01:00',
    time: '6:30 PM',
    num_attending: 19,
    url: 'https://www.meetup.com/founderscoders/events/241027536'
  )}

  let!(:event_array) {[
      {title: 'Coding for everyone', organiser: 'Founders & Coders', address: '14 Palmers Road, E2 0SY, London'},
      {title: 'Ruby Hack Night', organiser: 'London Ruby', address: '1 Elmer Road, WC1 0SY, London'},
      {title: 'Python for Business', organiser: 'London Python', address: '4 Palantir Road, N2 0SY, London'}
    ]}

  let!(:update_event_hash){{
    date: 'Monday, July 31, 2017',
    time: '6:30 PM to 8:00 PM',
    address: '14 Palmers Road, E2 0SY, London',
    description: "Come and join us for our regular Monday evening meetup and participate in any one of a number of peer-led JavaScript coding activities, including:  Free Code Camp projects  Solving and creating Codewars katas  Codecademy  Eloquent Javascript  CS50 This meetup is for everyone who wants to learn to code. During the meetup we encourage participants to work together with another meetup attendee on one laptop (pair programming). Students from the current cohort of Founders & Coders will be available for questions and support. Please note that laptops aren't provided, but since we encourage pair programming you are welcome to join us without a laptop and work with another participant. Founders and Coders, Code of Conduct: https://github.com/codingforeveryone/code-of-conduct Our community is dedicated to providing a harassment-free experience for everyone. We do not tolerate harassment of community members in any form. Participants violating these rules may be sanctioned or expelled from the event and any future events, as well as from the community itself. "
  }}

  after(:each) do
    MeetupScraper::Event.class_variable_set(:@@all, [])
  end

  describe '.create_from_hash' do
    it 'takes an argument hash, sets the new event\'s attributes and returns an event instance' do
      expect{MeetupScraper::Event.new.create_from_hash({
        title: 'Coding for everyone',
        organiser: 'Founders & Coders',
        date: '2017-07-31T23:30:00+01:00',
        time: '6:30 PM',
        num_attending: '19',
        url: 'https://www.meetup.com/founderscoders/events/241027536'})}.to_not raise_error

      expect(event.title).to eq('Coding for everyone')
      expect(event.organiser).to eq('Founders & Coders')
      expect(event.date).to eq('2017-07-31T23:30:00+01:00')
      expect(event.time).to eq('6:30 PM')
      expect(event.num_attending).to eq(19)
      expect(event.url).to eq('https://www.meetup.com/founderscoders/events/241027536')
    end

    it 'adds the new event to the event class collection' do
      expect(MeetupScraper::Event.class_variable_get(:@@all).size).to eq(1)
      expect(MeetupScraper::Event.class_variable_get(:@@all).first.title).to eq('Coding for everyone')
    end
  end

  describe '.create_from_collection' do
    it 'return a collection of event instances following scraping of meetup search results page' do
      MeetupScraper::Event.class_variable_set(:@@all, [])
      MeetupScraper::Event.create_from_collection(event_array)
      expect(MeetupScraper::Event.class_variable_get(:@@all).size).to eq(3)
      expect(MeetupScraper::Event.class_variable_get(:@@all).first.title).to eq('Coding for everyone')
      expect(MeetupScraper::Event.class_variable_get(:@@all).last.title).to eq('Python for Business')
    end
  end

  describe '#update_event_attributes' do
    it 'add or update attributes on the event instance with the results scraped from the events profile page' do
      event.update_event_attributes(update_event_hash)
      expect(event.date).to eq('Monday, July 31, 2017')
      expect(event.time).to eq('6:30 PM to 8:00 PM')
      expect(event.address).to eq('14 Palmers Road, E2 0SY, London')
      expect(event.description).to eq("Come and join us for our regular Monday evening meetup and participate in any one of a number of peer-led JavaScript coding activities, including:  Free Code Camp projects  Solving and creating Codewars katas  Codecademy  Eloquent Javascript  CS50 This meetup is for everyone who wants to learn to code. During the meetup we encourage participants to work together with another meetup attendee on one laptop (pair programming). Students from the current cohort of Founders & Coders will be available for questions and support. Please note that laptops aren't provided, but since we encourage pair programming you are welcome to join us without a laptop and work with another participant. Founders and Coders, Code of Conduct: https://github.com/codingforeveryone/code-of-conduct Our community is dedicated to providing a harassment-free experience for everyone. We do not tolerate harassment of community members in any form. Participants violating these rules may be sanctioned or expelled from the event and any future events, as well as from the community itself. ")
    end
  end

end
