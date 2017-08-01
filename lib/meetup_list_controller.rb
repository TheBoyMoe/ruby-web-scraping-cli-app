class MeetupListingController

  def call
    puts 'Search Meetup.com for meetups in you local area'
    puts 'Enter the meetup subject'
    subject = gets.chomp
    puts 'Enter your town'
    town = gets.chomp
    puts 'How many miles from your town are you willing to travel'
    miles = gets.chomp.to_i
    miles = 1 if miles == 0
    self.create_events_from_hashes(subject, town, miles)
  end

  # fetch the meetup events
  def search_meetup(subject, town, distance)
    base_url = 'https://www.meetup.com/find/events/?allMeetups=false&keywords='
    url = "#{base_url}#{subject}&radius=#{distance}&userFreeForm#{town}"
    Scraper.fetch_meetup_list(url)
  end

  # create event instances
  def create_events_from_hashes(subject, town, miles)
    event_hashes = self.search_meetup(subject, town, miles)
    # instantiate event objects & display meetup list
    Event.create_from_collection(event_hashes)
  end


  # TODO print event collection


  # TODO - download the event's details


  # TODO print event detatils

end
