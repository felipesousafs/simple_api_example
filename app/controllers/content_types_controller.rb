class ContentTypesController < ApplicationController
  before_action :set_content_type, only: [:show, :update, :destroy]

  # GET /content_types
  def index
    @content_types = ContentType.all

    render json: @content_types
  end

  # GET /content_types/1
  def show
    render json: @content_type
  end

  # POST /content_types
  def create
    @content_type = ContentType.new(content_type_params)

    if @content_type.save
      render json: @content_type, status: :created, location: @content_type
    else
      render json: @content_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /content_types/1
  def update
    if @content_type.update(content_type_params)
      render json: @content_type
    else
      render json: @content_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /content_types/1
  def destroy
    @content_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_type
      @content_type = ContentType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def content_type_params
      params.require(:content_type).permit(:name)
    end
end
