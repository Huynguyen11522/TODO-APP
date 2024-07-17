class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show update destroy ]

  def index
    @categories = Category.all

    render json: { status: 200, data: @categories }
  end

  def show
    render json: { status: 200, data: @category }
  end

  def create
  @category = Category.new(category_params)

    @category.save!
    render json:  { status: 200, message: 'Create successfully', data: @category }, status: :created
    rescue NoMethodError
      render json: {status: 400, message: "Bad Request"}, status: :bad_request
  end

  def update
    @category.update!(category_params)
    render json: { status: 200, statusMessage: 'Updated successfully' }, status: :ok
  end

  def destroy
    @category.destroy
    render json: { status: 200, message: "Delete successfully" }, status: :ok
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
