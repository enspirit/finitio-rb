$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'path'
require 'finitio'
require 'finitio/syntax'
require 'multi_json'

Finitio::TEST_SYSTEM = Finitio.system(Path.dir.parent/'fixtures/test-system.fio')
