require './lib/temp_converter.rb'
#require './lib/text_printer.rb'
require 'net/http'
require 'uri'





temp = ARGV.first.to_f
url = 'http://labict.be/software-engineering/temperature/api/temperature/fake'
path = 'C:\Users\Gebruiker\Documents\School\systeem\Oefenigen\01 Temp converter\temperatuur.txt'

#TextPrinter.print_textje
TempConverter.commandline_temperature(temp)
TempConverter.url_temperature(url)
TempConverter.file_temperature(path)
