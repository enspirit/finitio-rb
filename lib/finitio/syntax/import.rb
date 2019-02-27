module Finitio
  module Syntax
    module Import
      include Node

      capture :import_url

      def compile(system)
        file = system.resolve_url(import_url)
        imported = Finitio.send(:_system, file)
        system.add_import(imported)
        system
      end

      def to_ast
        [:import, import_url]
      end

    end # module Import
  end # module Syntax
end # module Finitio
