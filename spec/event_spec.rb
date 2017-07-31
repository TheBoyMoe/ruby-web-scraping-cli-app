require 'spec_helper'

describe 'Event' do

  let!(:event){Event.new(
    title: 'Coding for everyone',
    organiser: 'Founders & Coders',
    address: '14 Palmers Road, E2 0SY, London',
    date: 'Monday, July 31, 2017',
    time: '6:30 PM to 8:00 PM',
    description: "Come and join us for our regular Monday evening meetup and participate in any one of a number of peer-led JavaScript coding activities, including:  Free Code Camp projects  Solving and creating Codewars katas  Codecademy  Eloquent Javascript  CS50 This meetup is for everyone who wants to learn to code. During the meetup we encourage participants to work together with another meetup attendee on one laptop (pair programming). Students from the current cohort of Founders & Coders will be available for questions and support. Please note that laptops aren't provided, but since we encourage pair programming you are welcome to join us without a laptop and work with another participant. Founders and Coders, Code of Conduct: https://github.com/codingforeveryone/code-of-conduct Our community is dedicated to providing a harassment-free experience for everyone. We do not tolerate harassment of community members in any form. Participants violating these rules may be sanctioned or expelled from the event and any future events, as well as from the community itself. "
  )}

  after(:each) do
    Event.class_variable_set(:@@all, [])
  end

  describe '#new' do
    it 'takes an argument hash, sets the new event\'s attributes and returns an event instance' do
      expect{Event.new({
        title: 'Coding for everyone',
        organiser: 'Founders & Coders',
        address: '14 Palmers Road, E2 0SY, London',
        date: 'Monday, July 31, 2017',
        time: '6:30 PM to 8:00 PM'})}.to_not raise_error
      expect(event.title).to eq('Coding for everyone')
      expect(event.organiser).to eq('Founders & Coders')
      expect(event.address).to eq('14 Palmers Road, E2 0SY, London')
      expect(event.date).to eq('Monday, July 31, 2017')
      expect(event.time).to eq('6:30 PM to 8:00 PM')
    end

    it 'adds the new event to the event class collection' do
      expect(Event.class_variable_get(:@@all).size).to eq(1)
      expect(Event.class_variable_get(:@@all).first.title).to eq('Coding for everyone')
    end
  end


end
