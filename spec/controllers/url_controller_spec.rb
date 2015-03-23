require 'rails_helper'

RSpec.describe Api::V1::UrlController do
  before(:each) do
    @request.host = "api.example.com"
  end

  describe "GET index" do
    it "returns all urls in JSON" do
      create(:url)
      get :index

      urls = JSON.parse(response.body)
      first_url = urls.first

      expect(urls.count).to eq(1)
      expect(first_url["title"]).to eq("Factory Girl")
    end
  end

  describe "POST create" do
    it "can create a new url record" do
      url = {long: "https://google.com/some/sub/path"}
      post :create, url: url

      new_url = JSON.parse(response.body)

      expect(new_url["message"]).to eq("URL created!")
      expect(new_url["url"]).to be_a(Hash)
      expect(new_url["url"]["long"]).to eq(url[:long])
    end

    it "returns an error for an invalid post" do
      url = { short: "DFJKDF" }
      post :create, url: url

      new_url = JSON.parse(response.body)

      expect(new_url["message"]).to eq("Couldn't create URL, please try again.")
      expect(new_url["errors"].first).to eq("Long can't be blank")
    end
  end
end
