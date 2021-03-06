require 'text_reader.rb'
require 'url_reader.rb'
require 'text_printer.rb'
require 'json_printer.rb'
require 'html_printer.rb'

class TempConverter



  def self.to_print_all(c, f, k)
    TextPrinter.print(c, f, k)
    JsonPrinter.print(c, f, k)
    HtmlPrinter.print(c, f, k)
  end

  def self.calc_kelvin(t)
    return (t + 273.15)
  end

  def self.calc_fahr(t)
    return ((t*9/5)+32)
  end

  def self.commandline_temperature(temp)
    puts "Temperatuur uit powershell"
    kelvin = calc_kelvin(temp)
    fahr = calc_fahr(temp)
    to_print_all(temp, fahr, kelvin)
  end

  def self.url_temperature(link)
    puts "Temperatuur uit url"
    temp = UrlReader.open_url(link)
    kelvin = calc_kelvin(temp)
    fahr = calc_fahr(temp)
    to_print_all(temp, fahr, kelvin)
  end

  def self.file_temperature(file_name)
    puts "Temperatuur uit textdocument"
    temp = TextReader.open_file(file_name)
    kelvin = calc_kelvin(temp)
    fahr = calc_fahr(temp)
    to_print_all(temp, fahr, kelvin)
  end

  def self.get_file_temperature(file_name)
    return TextReader.open_file(file_name)
  end

end
