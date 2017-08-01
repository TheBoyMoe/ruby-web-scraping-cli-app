require 'spec_helper'

describe 'MeetupListingController' do
  let(:meetup_list_controller) {MeetupListingController.new}

  let!(:event_array) {[
      Event.new({
        title: 'Coding for everyone',
        organiser: 'Founders & Coders',
        date: '2017-07-28',
        time: '6:30 PM',
        num_attending: 19,
        url: 'https://www.meetup.com/founderscoders/events/241027536',
        location: 'Bethnel Green'
      }),
      Event.new({
        title: 'Ruby Hack Night',
        organiser: 'London Ruby',
        date: '2017-07-29T23:30:00+01:00',
        time: '6:30 PM',
        num_attending: 8,
        url: 'https://www.meetup.com/founderscoders/events/241027536',
        location: 'Hoxton'
      })
    ]}

  describe '#call' do
    it 'prompts user to enter the necessary details to execute a search of the meetup site' do
      allow(meetup_list_controller).to receive(:gets).and_return('Ruby')
      expect($stdout).to receive(:puts).with('Search Meetup.com for meetups in you local area')
      expect($stdout).to receive(:puts).with('Enter the meetup subject')
      expect($stdout).to receive(:puts).with('Enter your town')
      expect($stdout).to receive(:puts).with('How many miles from your town are you willing to travel')
      meetup_list_controller.call
    end
  end

  describe '#search_meetup' do
    it 'execute the search using the provided input provided by the user' do
      town = 'London'
      distance = 2
      subject = 'Ruby'
      events = meetup_list_controller.search_meetup(subject, town, distance)

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
      town = 'London'
      distance = 2
      subject = 'Ruby'
      event_instances = meetup_list_controller.create_events_from_hashes(subject, town, distance)
      expect(event_instances).to be_a(Array)
      expect(event_instances.first).to be_an_instance_of(Event)
    end
  end

  # describe '#print_meetup_events' do
  #   # TODO
  #   it 'prints out events matching the search criteria returned by date' do
  #     expect($stdout).to receive(:puts).with('1. Coding for everyone')
  #     expect($stdout).to receive(:puts).with('Founders & Coders')
  #     expect($stdout).to receive(:puts).with('2017-07-28')
  #     expect($stdout).to receive(:puts).with('6:30 PM')
  #     expect($stdout).to receive(:puts).with(19)
  #     expect($stdout).to receive(:puts).with('Bethnel Green')
  #     expect($stdout).to receive(:puts).with('------------------------------')
  #     expect($stdout).to receive(:puts).with('2. Ruby Hack Night')
  #     expect($stdout).to receive(:puts).with('London Ruby')
  #     expect($stdout).to receive(:puts).with('2017-07-29')
  #     expect($stdout).to receive(:puts).with('6:30 PM')
  #     expect($stdout).to receive(:puts).with(9)
  #     expect($stdout).to receive(:puts).with('Hoxton')
  #     expect($stdout).to receive(:puts).with('------------------------------')
  #
  #     meetup_list_controller.print_meetup_events
  #   end
  # end

end
