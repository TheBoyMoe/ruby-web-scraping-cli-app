class MeetupListingController

  # capture user input returning search url
  def get_user_input
    puts 'Search Meetup.com for events in you local area'
    puts 'Enter the meetup subject'
    subject = gets.chomp
    puts 'Enter your town'
    town = gets.chomp
    puts 'How many miles from your town are you willing to travel'
    miles = gets.chomp.to_i
    miles = 1 if miles == 0

    base_url = 'https://www.meetup.com/find/events/?allMeetups=false&keywords='
    "#{base_url}#{subject}&radius=#{miles}&userFreeForm=#{town}"
  end

  # fetch the meetup events
  def search_meetup(url)
    Scraper.fetch_meetup_list(url)
  end

  # create event instances
  def create_events_from_hashes(event_hashes)
    Event.create_from_collection(event_hashes)
  end

  # print event collection
  def print_meetup_events
    events = Event.all
    if events.size > 0
      print_events(events)
    else
      puts "No matching results found, try again."
    end

  end

  # prompt user to view more details on event of interest
  def pick_meetup_event
    puts 'Enter the number of the event you want more detail on'
    puts "Or enter '0' to search again"
    input = gets.chomp.to_i
    # if input == 0
    #   self.get_user_input
    # else
    #   url = Event.all[input - 1].url
    #
    # end
  end

  # TODO - download the event's details


  # TODO print event detatils


  private
  def print_events(events)
    events.each_with_index do |event, i|
      puts "------------------------------"
      puts "#{i + 1}. #{event.title}"
      puts "Organiser: #{event.organiser}"
      puts "Date: #{event.date.slice(0, 10)}"
      puts "Time: #{event.time}"
      puts "Number attending: #{event.num_attending}"
      puts "Url: #{event.url}"
      puts "Location: #{event.location}"
      puts "------------------------------"
    end
  end

end
