# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/controllers/locations_controller.rb
class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
    authorize(@location)
  end

  # GET /locations/1 or /locations/1.json
  def show
    authorize(@location)
  end

  # GET /locations/new
  def new
    @location = Location.new
    authorize(@location)
  end

  # GET /locations/1/edit
  def edit
    authorize(@location)
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)
    authorize(@location)
    respond_to do |format|
      if @location.save
        format.html { redirect_to(location_url(@location), notice: "Location was successfully created.") }
        format.json { render(:show, status: :created, location: @location) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @location.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    authorize(@location)
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to(location_url(@location), notice: "Location was successfully updated.") }
        format.json { render(:show, status: :ok, location: @location) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @location.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy
    authorize(@location)
    respond_to do |format|
      format.html { redirect_to(locations_url, notice: "Location was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:name, :description, :address, :company_id, :branch_id)
  end
end
