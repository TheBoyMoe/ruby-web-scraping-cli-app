class CommandLineInterface

  def call
    meetup_controller = MeetupListingController.new
    url = meetup_controller.get_user_input
    event_hashes = meetup_controller.search_meetup(url)
    meetup_controller.create_events_from_hashes(event_hashes)
  end
end
