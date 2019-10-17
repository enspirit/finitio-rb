require 'securerandom'
require_relative 'generation/heuristic'
module Finitio
  #
  # This class helps generating random data for a given Finitio type.
  #
  # Example
  #
  #     type = Finitio.system(<<-FIO)
  #       .Integer
  #     FIO
  #     gen = Finitio::Generation.new
  #     gen.call(type)
  #
  # Random data is generated for most ruby builtin types, tuples and all sorts
  # of collections (seq, set, relations).
  #
  # You can fine-tune the random data generation through the following means
  # (the first one wins):
  #
  # * By passing generators by type name at construction:
  #
  #       Finition::Generation.new({
  #         generators: {
  #           "Name" => ->(type, g, world) { "Bernard" }
  #         }
  #       })
  #
  # * Through `examples` metadata put on type definitions:
  #
  #       /- examples: {"Bernard"} -/
  #       Name = .String
  #
  class Generation

    DEFAULT_OPTIONS = {

      heuristic: Heuristic::Random.new,

      collection_size: 1..10,

      generators: {
        "Date"     => ->(t,g,w) { g.heuristic.call(Date, g, w) },
        "Time"     => ->(t,g,w) { g.heuristic.call(Time, g, w) },
        "DateTime" => ->(t,g,w) { g.heuristic.call(DateTime, g, w) }
      }

    }

    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options){|k,v1,v2|
        v1.is_a?(Hash) ? v1.merge(v2) : v2
      }
    end
    attr_reader :options

    def heuristic
      options[:heuristic]
    end

    def generators
      options[:generators]
    end

    def flip_coin
      flip_one_out_of(2) == 1
    end

    def flip_one_out_of(n)
      case n
      when Integer    then Kernel.rand(n)
      when Range      then Kernel.rand(n)
      when Enumerable then n[flip_one_out_of(n.size)]
      else
        raise "Cannot flip one on #{n}"
      end
    end

    def collection_size
      size = options[:collection_size]
      size = size.is_a?(Proc) ? size.call : size
      flip_one_out_of(size)
    end

    def call(type, world = nil)
      if gen = generators[type.name]
        gen.call(type, self, world)
      elsif exs = type.metadata && type.metadata[:examples]
        flip_one_out_of(exs)
      else
        type.generate_data(self, world)
      end
    end

  end # class Generation
end # module Finitio
require_relative 'generation/any_type'
require_relative 'generation/builtin_type'
require_relative 'generation/seq_type'
require_relative 'generation/set_type'
require_relative 'generation/hash_based_type'
require_relative 'generation/rel_based_type'
require_relative 'generation/union_type'
require_relative 'generation/alias_type'
require_relative 'generation/sub_type'
require_relative 'generation/ad_type'
