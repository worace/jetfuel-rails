class Api::V1::UrlController < ApplicationController
  def index
    @urls = Url.order("#{params[:sort_order]} DESC").paginate(page: params[:page], per_page: 10)

    render json: @urls
  end

  def create
    if Url.find_by(long: params[:url][:long])
      @url = Url.find_by(long: params[:url][:long])
      @url.add_request
      render json: @url
    elsif @url = Url.create(url_params)
      TitleWorker.perform_async(@url.id)
      render json: @url
    else
      render json: { message: "Couldn't create URL, please try again.", errors: @url.errors.full_messages }
    end
  end

  private

  def url_params
    params.require(:url).permit(:long, :title)
  end
end
