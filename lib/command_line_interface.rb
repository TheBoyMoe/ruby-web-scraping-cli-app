class CommandLineInterface

  def run
    controller = MeetupListingController.new
    url = controller.get_user_input
    event_hashes = controller.search_meetup(url)
    controller.create_events_from_hashes(event_hashes)
    controller.print_meetup_events
  end
end
