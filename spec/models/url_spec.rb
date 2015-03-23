require 'rails_helper'

RSpec.describe Url, type: :model do
  it { should validate_presence_of(:long) }

  it "creates a new 6 char short code on create" do
    url = create(:url, short: "")
    expect(url.short.length).to eq(6)
  end

  it "appends http if not present" do
    url = create(:url, long: "www.google.com")
    expect(url.long).to eq("http://www.google.com")
  end

  it "appends http even if www not present" do
    url = create(:url, long: "google.com")
    expect(url.long).to eq("http://google.com")
  end

  it "doesn't change an https url" do
    url = create(:url, long: "https://www.google.com")
    expect(url.long).to eq("https://www.google.com")
  end

  it "finds the site's title" do
    url = create(:url, long: "www.google.com")
    expect(url.title).to eq("Google")
  end
end
