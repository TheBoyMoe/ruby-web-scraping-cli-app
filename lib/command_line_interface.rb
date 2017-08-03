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
    #self.run
  end

  def print_meetup_event
    input = self.climethods.pick_meetup_event
    if (input.to_i >= 1 && input.to_i <= Event.all.size)
      event = Event.all[input.to_i - 1]
      url = event.url
      # down load event's details, update event attributes & print event
      updated_details = self.climethods.fetch_event_details(url)
      updated_event = event.update_event_attributes(updated_details)
      self.climethods.print_event(updated_event)
      self.run_again
    elsif input == '0'
      self.run
    else
      puts 'Good bye!'
    end
  end

  def run_again
    puts "Enter '1' to view listing again or '0' to search again"
    input = gets.chomp
    if input.to_i == 1
      self.print_meetup_events
    else
      self.run
    end
  end

end
