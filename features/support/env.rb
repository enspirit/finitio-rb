$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'qrb'
require 'qrb/syntax'
require 'multi_json'

Qrb::TEST_SYSTEM = Qrb.parse(File.read(File.expand_path('../test-system.q', __FILE__)))
