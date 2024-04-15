class FeaturesController < ApplicationController
  def index
    SismicDataService.fetch_and_save_data
    current_page = (params[:page].to_i || 1).to_i
    per_page = (params[:per_page].to_i || 10).to_i

    #api_data =
    @features = Feature.all
  end

  def show
    @feature = Feature.find(params[:id])
  end
end
