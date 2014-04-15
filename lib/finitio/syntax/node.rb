module Finitio
  module Syntax
    module Node

      def resolve_ruby_const(name)
        name.split('::').inject(::Kernel){|mod,const|
          mod.const_get(const)
        }
      end

      def self.included(by)
        by.extend(ClassHelpers)
      end

      module ClassHelpers

        def capture(*names)
          names.each do |name|
            define_method(name) do
              captures[name].first
            end
          end
        end

        def capture_str(*names)
          names.each do |name|
            define_method(name) do
              x = captures[name].first
              x && x.to_s
            end
          end
        end

      end # module ClassHelpers

    end # module Node
  end # module Syntax
end # module AstNode

require_relative 'type/system'
require_relative 'type/definitions'
require_relative 'type/type_def'
require_relative 'type/expression'
require_relative 'type/attribute'
require_relative 'type/heading'
require_relative 'type/any_type'
require_relative 'type/builtin_type'
require_relative 'type/sub_type'
require_relative 'type/constraint_def'
require_relative 'type/constraints'
require_relative 'type/named_constraint'
require_relative 'type/unnamed_constraint'
require_relative 'type/seq_type'
require_relative 'type/set_type'
require_relative 'type/struct_type'
require_relative 'type/tuple_type'
require_relative 'type/relation_type'
require_relative 'type/union_type'
require_relative 'type/type_ref'
require_relative 'type/ad_type'
require_relative 'type/contract'
require_relative 'type/inline_pair'
require_relative 'type/external_pair'
require_relative 'type/lambda_expr'
