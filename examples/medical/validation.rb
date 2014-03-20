require './commons'

source   = File.read('data.json')
jsondata = JSON.parse(source)

#ap jsondata

begin
  schema = Finitio.parse_schema(File.read('schema.fio'))
  ap schema.dress(jsondata)
rescue Finitio::TypeError => ex
  puts "[%s] :: %s" % [ex.location, ex.message]
end
