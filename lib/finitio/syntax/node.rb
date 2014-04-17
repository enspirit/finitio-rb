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

      def unique_names!(cs, kind = "constraint")
        names = {}
        cs.map(&:name).compact.each do |n|
          names.merge!(n => true) do |k,_,_|
            raise Error, "Duplicate #{kind} name `#{k}`"
          end
        end
        cs
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
