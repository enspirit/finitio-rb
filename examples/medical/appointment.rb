class Appointment

  def initialize(tuple)
    @tuple = tuple
  end

  def self.info(tuple)
    Appointment.new(tuple)
  end

  def to_info
    @tuple
  end

end
