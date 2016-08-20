class ResultsController < ApplicationController

  def index
    @results = Result.all
    render json: @results
  end

  def show
    @result = Result.find(params[:id])
    render json: @result
  end

end
