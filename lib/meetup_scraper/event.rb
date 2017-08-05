class MeetupScraper::Event
  attr_accessor :title, :date, :time, :url, :num_attending, :organiser, :address, :description
  @@all = []

  def create_from_hash(event_hash)
    event_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    save
    self
  end

  def self.create_from_collection(event_hashes)
    self.all.clear
    event_hashes.collect {|event_hash| self.new.create_from_hash(event_hash)}
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
