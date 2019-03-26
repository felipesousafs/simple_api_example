class Page < ApplicationRecord
  has_many :contents
  has_many :urls

  validates :link, presence: true

  after_save :process_page

  def process_page
    require 'open-uri'
    # Fetch and parse HTML document
    doc = Nokogiri::HTML(open(link))
    doc.css('h1', 'h2', 'h3').each do |header|
      content_type = ContentType.find_or_create_by(name: header.name)
      contents.create(content_type: content_type, text: header.text)
    end

    doc.css('link[href]').each do |element|
      urls.create(link: element['href'])
    end
  end
end
