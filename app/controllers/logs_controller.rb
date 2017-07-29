class LogsController < ApplicationController
  include Response
  include ExceptionHandler
  
  before_action :set_work
  before_action :set_work_log, only: [:show, :update, :destroy]

  # GET /works/:work_id/logs
  def index
    json_response(@work.logs)
  end

  # GET /works/:work_id/logs/:id
  def show
    json_response(@log)
  end

  # POST /works/:work_id/logs
  def create
    @work.logs.create!(log_params)
    json_response(@work, :created)
  end

  # PUT /works/:work_id/logs/:id
  def update
    @log.update(log_params)
    head :no_content
  end

  # DELETE /works/:work_id/logs/:id
  def destroy
    @log.destroy
    head :no_content
  end

  private

  def log_params
    params.permit(:note)
  end

  def set_work
    @work = Work.find(params[:work_id])
  end

  def set_work_log
    @log = @work.logs.find_by!(id: params[:id]) if @work
  end
end
