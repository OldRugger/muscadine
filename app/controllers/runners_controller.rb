class RunnersController < ApplicationController
  def import
    return render json: { message: "No input file specified"}, status: :unprocessable_entity if params[:file] == nil
    ActiveRecord::Base.transaction do
      @added, @skipped = Runner.import(params[:file])
    end
    render json: { added: @added, skipped: @skipped }, status: :created
  end

  def index
    render json: Runner.all.order(:entryclass)
  end
end
