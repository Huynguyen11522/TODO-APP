class TasksController < ApplicationController
  before_action :set_task, only: %i[ show update update_status destroy ]

  def index
    @post = Task.includes(:category)
    render json: { status: 200, data: @post.all}, include: [:category] if filter_params.empty?
    @post = @post.search_by(:status, filter_params[:status]) if filter_params[:status]
    
    render json: {status: 200, message: "Filter successfully", data: @post}, include: [:category]
  end

  def show
    render json: { status: 200, data: @task }, include: [:category]
  end

  def create
    @task = Task.new(task_params)
    @task.status = 1

    @task.save!
    render json: { status: 200, message: 'Create successfully', data: @task }, status: :created
    rescue NoMethodError
      render json: { status: 400, message: "Bad Request" }, status: :bad_request
  end

  def update 
    @task.update!(task_params)
    render json: {status: 200, message: "Update Status successfully"}, status: :ok
  end

  def update_status
    params.permit(:status)
    @task.update!(status: params[:status])
    render json: {status: 200, message: "Update Status successfully"}, status: :ok
  end

  def destroy
    @task.destroy!
    render json: { status: 200, message: "Delete successfully" }, status: :ok
  end

  private
  def set_task
    @task = Task.includes(:category).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Task not found' }, status: :not_found
  end

  def filter_params
    params.permit(:status, :date)
  end

  def task_params
    params.require(:task).permit(:title, :content, :startDate, :endDate, :category_id)
  end
end
