class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show update destroy ]

  def index
    @categories = Category.all

    render json: { status: STATUS_CODE[:ok], data: @categories }
  end

  def show
    render json: { status: STATUS_CODE[:ok], data: @category }
  end

  def create
    @category = Category.new(category_params)
    @category.title = @category.title.strip
    @category.content = @category.content.strip
    raise ActiveRecord::RecordNotFound unless @category.title.length > 0
    @category.save!
    render json:  { status: STATUS_CODE[:created], message: STATUS_MESSAGE[:create], data: @category }, status: :created
    rescue ActiveRecord::RecordNotFound
      render json: {status: STATUS_CODE[:bad_request], message: STATUS_MESSAGE[:bad_request] }, status: :bad_request
  end

  def update
    @category.update!(category_params)
    render json: { status: STATUS_CODE[:ok], statusMessage: STATUS_MESSAGE[:update] }, status: :ok
  end

  def destroy
    @category.destroy
    render json: { status: STATUS_CODE[:ok], message: STATUS_MESSAGE[:delete] }, status: :ok
  end

  private
    def set_category
      @category = Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Category not found' }, status: :not_found
    end

    def category_params
      params.require(:category).permit(:title, :content, :icon)
    end
end
