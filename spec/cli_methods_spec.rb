require 'spec_helper'

describe 'MeetupListingController' do
  let(:meetup_list_controller) {MeetupListingController.new}

  let!(:event_hashes) {[
      {
        title: 'Coding for everyone',
        organiser: 'Founders & Coders',
        date: '2017-07-28',
        time: '6:30 PM',
        num_attending: 19,
        url: 'https://www.meetup.com/founderscoders/events/241027536',
        location: 'Bethnel Green'
      },
      {
        title: 'Ruby Hack Night',
        organiser: 'London Ruby',
        date: '2017-07-29T23:30:00+01:00',
        time: '6:30 PM',
        num_attending: 8,
        url: 'https://www.meetup.com/ruby-hack-night/events/230852789',
        location: 'Hoxton'
      }
    ]}

  describe '#get_user_input' do
    it 'prompts user to enter the necessary details to execute a search of the meetup site' do
      allow(meetup_list_controller).to receive(:gets).and_return('url')
      expect($stdout).to receive(:puts).with('Search Meetup.com for meetups in you local area')
      expect($stdout).to receive(:puts).with('Enter the meetup subject')
      expect($stdout).to receive(:puts).with('Enter your town')
      expect($stdout).to receive(:puts).with('How many miles from your town are you willing to travel')
      meetup_list_controller.get_user_input
    end
  end

  describe '#search_meetup' do
    it 'execute the search using the input provided by the user' do
      url = 'https://www.meetup.com/find/events/?allMeetups=false&keywords=javascript&radius=2&userFreeform=London%2C+United+Kingdom'
      events = meetup_list_controller.search_meetup(url)
      expect(events).to be_a(Array)

      expect(events.first).to have_key(:title)
      expect(events.first).to have_key(:organiser)
      expect(events.first).to have_key(:url)
      expect(events.first).to have_key(:location)
      expect(events.first).to have_key(:num_attending)
      expect(events.first).to have_key(:time)
      expect(events.first).to have_key(:date)
    end
  end

  describe '#create_events_from_hashes' do
    it 'convert event hashes returned by search into collection of event instances' do
      event_instances = meetup_list_controller.create_events_from_hashes(event_hashes)
      expect(event_instances).to be_a(Array)
      expect(event_instances.first).to be_an_instance_of(Event)
    end
  end

  describe '#print_meetup_events' do

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
      expect($stdout).to receive(:puts).with('Location: Bethnel Green')
      expect($stdout).to receive(:puts).with('------------------------------')
      expect($stdout).to receive(:puts).with('------------------------------')
      expect($stdout).to receive(:puts).with('2. Ruby Hack Night')
      expect($stdout).to receive(:puts).with('Organiser: London Ruby')
      expect($stdout).to receive(:puts).with('Date: 2017-07-29')
      expect($stdout).to receive(:puts).with('Time: 6:30 PM')
      expect($stdout).to receive(:puts).with('Number attending: 8')
      expect($stdout).to receive(:puts).with('Url: https://www.meetup.com/ruby-hack-night/events/230852789')
      expect($stdout).to receive(:puts).with('Location: Hoxton')
      expect($stdout).to receive(:puts).with('------------------------------')

      meetup_list_controller.print_meetup_events
    end
  end

  describe '#fetch_'

end
