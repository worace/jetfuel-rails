class Url < ActiveRecord::Base
  validates :long, presence: true
  validates :short, uniqueness: true
  before_validation :generate_short_code, on: [:create]
  before_save :smart_add_url_protocol
  after_save :pull_page_title

  private

  def generate_short_code
    length = 6
    self.short = rand(36**length).to_s(36)
  end

  def smart_add_url_protocol
    unless long[/\Ahttp:\/\//] || long[/\Ahttps:\/\//]
      self.long = "http://#{long}"
    end
  end

  def pull_page_title
    doc = Nokogiri::HTML(HTTParty.get(long))
    self.title = doc.css("title").first.child.text
  end
end
