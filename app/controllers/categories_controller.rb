class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :set_categories, only: [:index, :edit, :new]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
    @category = Category.new
    @categories_ids = Category.all.map{ |category| [category.name, category.id]}
    @types = Type.all
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    unless @category.save
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def api
    @markers = Marker.all
    @category_api = Category.where(public: true)
    hash_final = {}
    marker_array = []
    category_array = []

    @markers.each do |m|
      obj_marker = {
        name: m.name,
        url: m.url,
      } 
      marker_array.push(obj_marker)
    end
    
    hash_final[:Markers] = marker_array

    @category_api.each do |c|
      obj_cat = {
        name: c.name,
        public: c.public,
        type_name: c.name_type,
        
  
      } 
      category_array.push(obj_cat)
    end
    hash_final[:Categories] = category_array
    render json: hash_final
    
  end


  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    @category.update(category_params)
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    if @category.destroy
      @categories = Category.all.order(updated_at: :desc)
      respond_to do |format|
        format.js { render nothing: true }
        format.html { redirect_to categories_url, notice: "Post was successfully destroyed." }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def set_categories
      @categories_ids = Category.all.map{ |category| [category.name, category.id]}
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :public, :category_id, :type_id)
    end
end
