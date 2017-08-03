require 'spec_helper'

describe 'CliMethods' do
  let(:climethods) {CliMethods.new}

  let(:event_hashes) {[
    {
      title: 'Coding for everyone',
      organiser: 'Founders & Coders',
      date: '2017-07-28',
      time: '6:30 PM',
      num_attending: 19,
      url: 'https://www.meetup.com/founderscoders/events/241027536'
    },
    {
      title: 'Ruby Hack Night',
      organiser: 'London Ruby',
      date: '2017-07-29T23:30:00+01:00',
      time: '6:30 PM',
      num_attending: 8,
      url: 'https://www.meetup.com/ruby-hack-night/events/230852789'
    }
  ]}

  let(:event_instance) {Event.new.create_from_hash({
    title: 'Coding for everyone',
    organiser: 'Founders & Coders',
    date: 'Monday, July 31, 2017',
    time: '6:30 PM to 8:00 PM',
    num_attending: 19,
    url: 'https://www.meetup.com/founderscoders/events/241027536',
    address: '14 Palmers Road, E2 0SY, London',
    description: "Come and join us for our regular Monday evening meetup and participate in any one of a number of peer-led JavaScript coding activities, including: • Free Code Camp projects • Solving and creating Codewars katas • Codecademy • Eloquent Javascript • CS50 This meetup is for everyone who wants to learn to code. During the meetup we encourage participants to work together with another meetup attendee on one laptop (pair programming). Students from the current cohort of Founders & Coders will be available for questions and support. Please note that laptops aren't provided, but since we encourage pair programming you are welcome to join us without a laptop and work with another participant. Founders and Coders, Code of Conduct: https://github.com/codingforeveryone/code-of-conduct Our community is dedicated to providing a harassment-free experience for everyone. We do not tolerate harassment of community members in any form. Participants violating these rules may be sanctioned or expelled from the event and any future events, as well as from the community itself."
  })}

  describe '#get_user_input' do
    it 'prompts user to enter the necessary details to execute a search of the meetup site' do
      allow(climethods).to receive(:gets).and_return('url')
      expect($stdout).to receive(:puts).with('Search Meetup.com for events in your local area')
      expect($stdout).to receive(:puts).with('Enter the meetup subject')
      expect($stdout).to receive(:puts).with('Enter your town')
      expect($stdout).to receive(:puts).with('How many miles from your town are you willing to travel')
      climethods.get_user_input
    end
  end

  describe '#search_meetup' do
    it 'execute the search using the input provided by the user' do
      url = 'https://www.meetup.com/find/events/?allMeetups=false&keywords=javascript&radius=2&userFreeform=London%2C+United+Kingdom'
      events = climethods.search_meetup(url)
      expect(events).to be_a(Array)

      expect(events.first).to have_key(:title)
      expect(events.first).to have_key(:organiser)
      expect(events.first).to have_key(:url)
      expect(events.first).to have_key(:num_attending)
      expect(events.first).to have_key(:time)
      expect(events.first).to have_key(:date)
    end
  end

  describe '#create_events_from_hashes' do
    it 'convert event hashes returned by search into collection of event instances' do
      event_instances = climethods.create_events_from_hashes(event_hashes)
      expect(event_instances).to be_a(Array)
      expect(event_instances.first).to be_an_instance_of(Event)
    end
  end

  describe '#print_events' do
    it 'prints out events matching the search criteria returned by date' do
      Event.class_variable_set(:@@all, [])
      Event.create_from_collection(event_hashes)
      expect($stdout).to receive(:puts).with('------------------------------')
      expect($stdout).to receive(:puts).with('1. Coding for everyone')
      expect($stdout).to receive(:puts).with('Organiser: Founders & Coders')
      expect($stdout).to receive(:puts).with('Date: 2017-07-28')
      expect($stdout).to receive(:puts).with('Time: 6:30 PM')
      expect($stdout).to receive(:puts).with('Number attending: 19')
      expect($stdout).to receive(:puts).with('Url: https://www.meetup.com/founderscoders/events/241027536')
      expect($stdout).to receive(:puts).with('------------------------------')
      expect($stdout).to receive(:puts).with('------------------------------')
      expect($stdout).to receive(:puts).with('2. Ruby Hack Night')
      expect($stdout).to receive(:puts).with('Organiser: London Ruby')
      expect($stdout).to receive(:puts).with('Date: 2017-07-29')
      expect($stdout).to receive(:puts).with('Time: 6:30 PM')
      expect($stdout).to receive(:puts).with('Number attending: 8')
      expect($stdout).to receive(:puts).with('Url: https://www.meetup.com/ruby-hack-night/events/230852789')
      expect($stdout).to receive(:puts).with('------------------------------')

      climethods.print_events
    end
  end

  describe '#pick_meetup_event' do
    it 'prompts the user to select a meetup to get more details, start the search process again or exit' do
      allow(climethods).to receive(:gets).and_return('Testing for #pick_meetup_event')
      expect($stdout).to receive(:puts).with('Enter the number of the event you want more details on')
      expect($stdout).to receive(:puts).with("Or enter '0' to search again")

      climethods.pick_meetup_event
    end
  end

  describe '#fetch_event_details' do
    it 'download the full details for the event' do
      url = 'https://www.meetup.com/founderscoders/events/241763286/'
      event = climethods.fetch_event_details(url)

      expect(event).to be_a(Hash)
      expect(event).to have_key(:date)
      expect(event).to have_key(:time)
      expect(event).to have_key(:address)
      expect(event).to have_key(:description)
    end
  end

  describe '#print_event' do
    it "text" do
      expect($stdout).to receive(:puts).with('------------------------------')
      expect($stdout).to receive(:puts).with('Title: Coding for everyone')
      expect($stdout).to receive(:puts).with('Organiser: Founders & Coders')
      expect($stdout).to receive(:puts).with('Date: Monday, July 31, 2017')
      expect($stdout).to receive(:puts).with('Time: 6:30 PM to 8:00 PM')
      expect($stdout).to receive(:puts).with('Number attending: 19')
      expect($stdout).to receive(:puts).with('Address: 14 Palmers Road, E2 0SY, London')
      expect($stdout).to receive(:puts).with("Description: Come and join us for our regular Monday evening meetup and participate in any one of a number of peer-led JavaScript coding activities, including: • Free Code Camp projects • Solving and creating Codewars katas • Codecademy • Eloquent Javascript • CS50 This meetup is for everyone who wants to learn to code. During the meetup we encourage participants to work together with another meetup attendee on one laptop (pair programming). Students from the current cohort of Founders & Coders will be available for questions and support. Please note that laptops aren't provided, but since we encourage pair programming you are welcome to join us without a laptop and work with another participant. Founders and Coders, Code of Conduct: https://github.com/codingforeveryone/code-of-conduct Our community is dedicated to providing a harassment-free experience for everyone. We do not tolerate harassment of community members in any form. Participants violating these rules may be sanctioned or expelled from the event and any future events, as well as from the community itself.")
      expect($stdout).to receive(:puts).with('------------------------------')

      climethods.print_event(event_instance)
    end
  end

end
