module Finitio
  module Syntax
    module Expr
      include Node

      def self.included(by)
        by.extend(Node::ClassHelpers)
      end

      def to_proc(varnames = [])
        ::Kernel.eval "->(#{varnames.join(',')}){ #{to_proc_source(varnames)} }"
      end

      def to_proc_source(varnames)
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
