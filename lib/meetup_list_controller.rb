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
    self.search_meetup(subject, town, miles)
  end


  def search_meetup(subject, town, distance)
    #puts "Town: #{town}, distance: #{distance}, subject: #{subject}"
    base_url = 'https://www.meetup.com/find/events/?allMeetups=false&keywords='
    url = "#{base_url}#{subject}&radius=#{distance}&userFreeForm#{town}"
    Scraper.fetch_meetup_list(url)
  end

  

end
