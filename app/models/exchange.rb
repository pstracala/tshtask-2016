class Exchange < ActiveRecord::Base
  has_many :currencies
  require 'nokogiri'
  require 'open-uri'
  
  def get_nbp_xml
    Nokogiri::XML(open("http://www.nbp.pl/kursy/xml/LastC.xml"))
  end

  def save_current_rates
    nbp_xml = get_nbp_xml
    date = nbp_xml.at_xpath('//data_publikacji').content

    return if Exchange.find_by_name(date)
    
    self.name = date
    nbp_xml.xpath('//pozycja').each do |record|
      self.currencies.new(parse_rates(record))
    end
    save
  end

  def parse_rates(record)
    {
        name: record.at_xpath('nazwa_waluty').content,
        converter: record.at_xpath('przelicznik').content,
        code: record.at_xpath('kod_waluty').content,
        buy_price: record.at_xpath('kurs_kupna').content.gsub!(',', '.').to_f,
        sell_price: record.at_xpath('kurs_sprzedazy').content.gsub!(',', '.').to_f
    }
  end

end
