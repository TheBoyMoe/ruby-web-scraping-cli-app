=begin
  url: 'https://www.meetup.com/find/events/?allMeetups=false&keywords=javascript&radius=2&userFreeform=London%2C+United+Kingdom'
=end

class MeetupScraper::Scraper

  def self.fetch_meetup_list(url)
    doc = Nokogiri::HTML(open(url))
    items = doc.css('.searchResults .event-listing-container .event-listing')

    items.collect do |item|
      event = {}
      title = item.css('.chunk a.event span').inner_text
      if title != ''
        event[:title] = title
        event[:organiser] = item.css('.chunk .text--labelSecondary a span').inner_text
        event[:url] = item.css('a').first.attr('href')
        num_attending = item.css('.text--secondary .attendee-count').inner_text
        event[:num_attending] = num_attending.strip.slice(0, 4).gsub(/[^\d]/, '')
      end
      time = item.css('.text--secondary time').text
      if time != ''
        event[:time] = time
        event[:date] = item.css('time').attr('datetime').value
      end
      # event[:location] = item.css('.row-item')[1].css('.text--secondary a').text.strip
      event
    end
  end

  def self.fetch_event_details(url)
    doc = Nokogiri::HTML(open(url))
    items = doc.css('#event-content')
    event = {}
    items.each do |item|
      event[:date] = item.css('#event-when-display h3').text
      event_start_time = item.css('#event-start-time span').text
      event_end_time = item.css('#event-end-time span').text
      if (event_end_time != nil && event_end_time != '') && (event_start_time != nil && event_start_time != '')
        event[:time] = "#{event_start_time} to #{event_end_time}"
      else
        time = item.css('#event-when-display p').text
        event[:time] = time if time != '' || time != nil
      end
      address = item.css('#event-where-display .event-where-address').text.gsub(/\(map\)/, '').strip
      address = 'Signup to view address' if address == nil || address == ''
      event[:address] = address
      description_text = ''
      paragraphs = item.css('#event-description-wrap p')
      paragraphs.each {|p| description_text += p.text.gsub(/â\u0080¢/, '') + "\n"}
      event[:description] = description_text.strip
    end
    event
  end

end
