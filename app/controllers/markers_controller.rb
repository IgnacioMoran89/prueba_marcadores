class MarkersController < ApplicationController
  before_action :set_marker, only: %i[ show edit update destroy ]

  # GET /markers or /markers.json
  def index
    @markers = Marker.all
    @marker = Marker.new
    @markers = Marker.all.order(name: :desc)

  end

  # GET /markers/1 or /markers/1.json
  def show
  end

  # GET /markers/new
  def new
    @marker = Marker.new
  end

  # GET /markers/1/edit
  def edit
  end

  # POST /markers or /markers.json
  def create
    @marker = Marker.new(marker_params)
    unless @marker.save
      render json: @marker.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /markers/1 or /markers/1.json
  def update
    @marker.update(marker_params)
  end

  # DELETE /markers/1 or /markers/1.json
  def destroy
    if @marker.destroy
      @markers = Marker.all.order(updated_at: :desc)
      respond_to do |format|
        format.js { render nothing: true }
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marker
      @marker = Marker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def marker_params
      params.require(:marker).permit(:name, :url, :category_id, {category_ids: []})
    end
end
