class HomeController < ApplicationController

  def index
      url = "http://store.nike.com/us/en_us/pw/mens-nikeid-lifestyle-shoes/1k9Z7puZoneZoi3"

      @results = []

      response = HTTParty.get url

      dom = Nokogiri::HTML(response.body)

      dom.css(".product-name").map do |element|
          @results << element.content
      end
  end
end
