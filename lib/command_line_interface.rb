class CommandLineInterface
  attr_reader :controller

  def initialize
    @controller = MeetupListingController.new
    self.run
  end

  def run
    url = self.controller.get_user_input
    event_hashes = controller.search_meetup(url)
    controller.create_events_from_hashes(event_hashes)
    self.print_meetup_events
  end

  def print_meetup_events
    events = Event.all
    puts "Size: #{events.size}"
    while events.size < 1
      puts "Sorry, no matches found, try again."
      puts '------------------------------------'
      self.run
    end
    self.controller.print_events(events)
    self.pick_meetup_event
  end

  def pick_meetup_event
    puts 'Enter the number of the event you want more details on'
    puts "Or enter '0' to search again"
    input = gets.chomp.to_i
    if (input >= 1 && input <= Event.all.size)
      url = Event.all[input - 1].url
      puts "Selection url #{url}"
      # TODO down load event's details

      # TODO print said event
    else
      self.run
    end
  end
end
