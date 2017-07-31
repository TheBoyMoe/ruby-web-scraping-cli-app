require 'spec_helper'

describe 'MeetupListingController' do
  let(:meetup_list_controller) {MeetupListingController.new}

  describe '#call' do
    it 'prompts user to enter the necessary details to execute a search of the meetup site' do
      # expect(meetup_list_controller).to receive(:gets)
      expect($stdout).to receive(:puts).with('Search Meetup.com for meetups in you local area')
      expect($stdout).to receive(:puts).with('Enter the meetup subject')
      expect($stdout).to receive(:puts).with('Enter your town')
      expect($stdout).to receive(:puts).with('How many miles from your town are you willing to travel')
      expect(meetup_list_controller.call)
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

  

end
