class Api::V1::UrlController < ApplicationController
  include UrlHelper

  def index
    @urls = Url.search(params[:search]).order("#{params[:sort_order]} DESC").paginate(page: params[:page], per_page: 25)

    render json: @urls
  end

  def create
    long = add_http(params[:url][:long])
    if Url.find_by(long: long)
      @url = add_request(long)
      render json: @url
    elsif @url = Url.create(url_params)
      TitleWorker.perform_async(@url.id)
      render json: @url
    else
      render json: { message: "Couldn't create URL, please try again.",
                     errors: @url.errors.full_messages }
    end
  end

  private

  def url_params
    params.require(:url).permit(:long, :title)
  end
end
