require 'pp'

class WorksController < ApplicationController
  include Response
  include ExceptionHandler
  
  before_action :set_work, only: [:show, :update, :destroy]
  
  # GET /works
  def index
    @works = current_user.works
    json_response(@works)
  end
  
  # POST /works
  def create
    @work = current_user.works.create!(work_params)
    pp @work
    json_response(@work, :created)
  end
  
  # Get /works/:id
  def show
    json_response(@work)
  end
  
  # PUT /works/:id
  def update
    @work.update(work_params)
    head :no_content
  end
  
  # DELETE /works/:id
  def destroy
    @work.destroy
    head :no_content
  end

  private

  def work_params
    # whitelist params
    params.permit(:project, :status, :worktype, :material, :general_notes, 
     :surface_notes, :height, :diameter, :width, :depth, :units, :price, )
  end

  def set_work
    @work = Work.find(params[:id])
  end
end
