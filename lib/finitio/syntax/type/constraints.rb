module Finitio
  module Syntax
    module Constraints
      include Node

      def compile(var_name)
        unique_names! captures[:constraint].map{|c| c.compile(var_name) }
      end

      def to_ast(var_name)
        captures[:constraint].map{|c| c.to_ast(var_name) }
      end

    private

      def unique_names!(cs)
        names = {}
        cs.map(&:name).compact.each do |n|
          names.merge!(n => true) do |k,_,_|
            raise Error, "Duplicate constraint name `#{k}`"
          end
        end
        cs
      end

    end # module Constraints
  end # module Syntax
end # module Finitio
