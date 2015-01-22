module Finitio
  module Syntax
    module Expr
      include Node

      WORLD_VAR = "__world"

      def self.included(by)
        by.extend(Node::ClassHelpers)
      end

      def to_proc(options = { fetch_mode: :string })
        initializer = free_variables
          .map{|v| "#{v} = __world.fetch(:#{v})" }
          .join("\n")
        ::Kernel.eval <<-SRC
          ->(__world){
            #{initializer}
            #{to_proc_source}
          }
        SRC
      end

      def to_proc_source
        raise NotImplementedError
      end

      def free_variables
        [].tap{|fvs| _free_variables(fvs) }.uniq
      end

      def _free_variables(fvs)
        raise NotImplementedError
      end

    end # module Expr
  end # module Syntax
end # module Finitio
require_relative 'expr/logic_dyadic'
require_relative 'expr/logic_not'
require_relative 'expr/comparison'
require_relative 'expr/arith_op'
require_relative 'expr/unary_minus_op'
require_relative 'expr/oo_call'
require_relative 'expr/fn_call'
require_relative 'expr/identifier'
require_relative 'expr/literal'
require_relative 'expr/parenthesized'
