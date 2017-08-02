class CommandLineInterface
  attr_reader :climethods

  def initialize
    @climethods = CliMethods.new
  end

  def run
    url = self.climethods.get_user_input
    event_hashes = climethods.search_meetup(url)
    climethods.create_events_from_hashes(event_hashes)
    self.print_meetup_events
  end

  def print_meetup_events
    events = Event.all
    while events.size < 1
      puts "Sorry, no matches found, try again."
      puts '------------------------------------'
      self.run
    end
    self.climethods.print_events
    self.print_meetup_event
  end

  def print_meetup_event
    input = self.climethods.pick_meetup_event
    if (input.to_i >= 1 && input.to_i <= Event.all.size)
      url = Event.all[input.to_i - 1].url

      # TODO down load event's details
      event = self.climethods.fetch_event_details(url)
      puts "#{event}"
      # TODO print said event
    else
      self.run
    end
  end
end
