require 'rails_helper'

RSpec.describe Url, type: :model do
  it { should validate_presence_of(:long) }

  it "creates a new 6 char short code on create" do
    url = create(:url, short: "")
    expect(url.short.length).to eq(6)
  end
end
