class Event
  attr_accessor :title, :date, :time, :organiser, :address, :description
  @@all = []

  def initialize(event_hash)
    event_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    save
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

end
