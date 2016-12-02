require 'temp_converter.rb'
require 'net/http'
require 'uri'
require 'rubygems'
require 'mqtt'
require 'json'
require 'optparse'
require 'text_reader.rb'
require 'url_reader.rb'
require 'text_printer.rb'
require 'json_printer.rb'
require 'html_printer.rb'

globalTemperature = 0
path = 'C:\Users\Gebruiker\Documents\School\systeem\Oefenigen\01 Temp converter\temperatuur.txt'
link = 'http://labict.be/software-engineering/temperature/api/temperature/fake'


OptionParser.new do |opts|
  c = 0
  opts.banner = "Usage: ruby app.rb [options]"
  #temperatuur uit file
  opts.on("-file", "string file directory" ) do
    puts "this is the temperature from your file"
    c = TempConverter.get_file_temperature(path)
  end

  #temperatuur uit URL
  opts.on("-url", "link to temperature") do
    puts "temperature from link"
    c = UrlReader.open_url(link)
  end

  #temperatuur uit cmd
  opts.on("-t", "--string temperature", String, "enter your temperature") do |temperature|

    puts "temperature from command window"
    c = temperature.to_f
  end

  #temperatuur uit qtmt

  opts.on("-m", "temperature van mqtt") do

    client = MQTT::Client.new
    client.host = 'staging.thethingsnetwork.org'
    client.port = '1883'
    client.username = '70B3D57ED00012B2'
    client.password = 'c8iuTSccnypK1eoFzEb/OoqB2FVAiFg/aEaYesnNf4w='
    client.connect
    c = 0
    topic, message=client.get('70B3D57ED00012B2/devices/00000000AE6C63E4/up')

    puts tuid = JSON.parse(message)['fields']['temperature']
    c = tuid.to_f
  end

  f = TempConverter.calc_fahr(c)
  k = TempConverter.calc_kelvin(c)

  #Tweede opts om de text te printen naar volgens de voorwaarde
  opts.on("--text", "enter your file directory" ) do
    TextPrinter.print(c, f, k)
  end
  opts.on("--json", "enter your file directory" ) do
    JsonPrinter.print(c, f, k)
  end
  opts.on("--html", "enter your file directory" ) do
    HtmlPrinter.print(c, f, k)
  end
end.parse!
