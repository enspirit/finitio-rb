module Finitio
  module Syntax

    module Support

      def resolve_ruby_const(name)
        name.split('::').inject(::Kernel){|mod,const|
          mod.const_get(const)
        }
      end

    end # module Support

    module AstNode

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

    end # module AstNode

  end # module Syntax
end # module Finitio
