$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'finitio'
require 'finitio/syntax'
require 'multi_json'

Finitio::TEST_SYSTEM = Finitio.parse(File.read(File.expand_path('../test-system.fio', __FILE__)))
