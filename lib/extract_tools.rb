require 'httparty'
require 'nokogiri'

module ExtractTools
  class ResponseError < StandardError

  end

  class ImageExtractor

    def initialize(url)
      validate_url(url)
      @url = url.to_s
    end

    def fetch_page
      response = HTTParty.get(@url)
      case response.code
      when 404
        raise ResponseError, "404: Page not found"
      when 500
        raise ResponseError, "500: Internal server error"
      end
      response.body
    end

    def page_body
      @page_body ||= fetch_page
    end

    def reload_page
      @page_body = fetch_page
    end

    def extract_images
      doc = Nokogiri::HTML(page_body)
      doc.css("img").map {|img| process_link(img.attributes["src"] && img.attributes["src"].value) }.compact
    end

    private

    def validate_url(url)
      raise ArgumentError, "Supplied url must be either a String or an URI object." unless url.is_a?(String) || url.is_a?(URI)
      raise ArgumentError, "Supplied url is invalid" unless URI::regexp =~ url.to_s
    end

    def process_link(image_link)
      return nil if image_link.nil? || image_link.empty?
      image_link =~ URI::regexp ? image_link : URI.join(@url, image_link).to_s
    end

  end
end
