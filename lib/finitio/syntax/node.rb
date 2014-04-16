module Finitio
  module Syntax
    module Node

      def resolve_ruby_const(name)
        name.split('::').inject(::Kernel){|mod,const|
          mod.const_get(const)
        }
      end

      def metadata
        m = captures[:metadata].first
        m && m.value
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
