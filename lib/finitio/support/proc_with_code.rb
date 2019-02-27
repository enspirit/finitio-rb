module Finitio
  class ProcWithCode < Proc

    def self.new(*args, &bl)
      return Proc.new(*args, &bl) unless args.size == 2 && bl.nil?

      p = Kernel.eval("->(#{args.first}){ #{args.last} }")
      p.instance_variable_set(:@_finitio_src, args)

      def p.finitio_src
        @_finitio_src
      end

      def p.hash
        @_finitio_src.hash
      end

      def p.==(other)
        super || (
          other.is_a?(Proc) &&
          other.respond_to?(:finitio_src) &&
          other.finitio_src == self.finitio_src
        )
      end

      def p.eql?(other)
        self.==(other)
      end

      p
    end

  end # module ProcWithCode
end # module Finitio
