module Finitio
  module Version

    MAJOR = 0
    MINOR = 7
    TINY  = "0-rc4"

    def self.to_s
      [ MAJOR, MINOR, TINY ].join('.')
    end

  end
  VERSION = Version.to_s
end
