class Event
  attr_accessor :title, :date, :time, :url, :location, :num_attending, :organiser, :address, :description
  @@all = []

  def initialize(event_hash)
    event_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    save
  end

  def self.create_from_collection(events_array)
    events_array.each {|event_hash| self.new(event_hash)}
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def update_event_attributes(event_hash)
    event_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    self
  end

end
