require './commons'

data = JSON.parse(File.read('data.json'))

#ap data

begin
  schema = Qrb.parse_schema(File.read('schema.q'))
  ap schema.undress(data)
rescue Qrb::TypeError => ex
  puts "[%s] :: %s" % [ex.location, ex.message]
end
