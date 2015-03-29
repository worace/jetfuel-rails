module UrlHelper
  def add_http(long)
    unless long[/\Ahttp:\/\//] || long[/\Ahttps:\/\//]
      long = "http://#{long}"
    else
      long
    end
  end

  def add_request(long)
    @url = Url.find_by(long: long)
    @url.add_request
    @url
  end
end
