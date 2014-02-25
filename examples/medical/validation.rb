require './commons'

source   = File.read('data.json')
jsondata = JSON.parse(source)

#ap jsondata

begin
  schema = Qrb.parse_schema(File.read('schema.q'))
  ap schema.dress(jsondata)
rescue Qrb::TypeError => ex
  puts "[%s] :: %s" % [ex.location, ex.message]
end
