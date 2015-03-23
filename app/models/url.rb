class Url < ActiveRecord::Base
  validates :long, presence: true
  validates :short, uniqueness: true
  before_validation :generate_short_code, on: [:create]
  before_create :parse_uri

  private

  def generate_short_code
    length = 6
    self.short = rand(36**length).to_s(36)
  end

  def parse_uri
    self.long = URI.encode(self.long)
  end
end
