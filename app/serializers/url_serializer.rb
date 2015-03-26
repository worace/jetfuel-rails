class UrlSerializer < ActiveModel::Serializer
  attributes :id, :short, :long, :title, :short_url, :requests

  def short_url
    object.short_url
  end
end
