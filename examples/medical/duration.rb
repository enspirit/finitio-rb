class Duration

  def initialize(sec)
    @sec = sec
  end

  def self.minutes(min)
    Duration.new(min * 60)
  end

  def to_minutes
    @sec / 60
  end

  def to_s
    "Duration(#{@sec} sec.)"
  end

  def hash
    Duration.hash ^ @sec.hash
  end

  def ==(other)
    other.is_a?(Duration) && other.sec == self.sec
  end

private
  attr_reader :sec

end
