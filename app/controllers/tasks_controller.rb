class TasksController < ApplicationController
  before_action :set_task, only: %i[ show update update_status destroy ]

  def index
    @post = Task.includes(:category)
    render json: { status: STATUS_CODE[:ok], data: @post.all}, include: [:category] if filter_params.empty?
    @post = @post.search_by(:status, filter_params[:status]) if filter_params[:status]
    @post = @post.date_between(filter_params[:date].to_datetime.strftime('%FT%R')) if filter_params[:date]
    render json: {status: STATUS_CODE[:ok], message: STATUS_MESSAGE[:filter], data: @post}, include: [:category] unless filter_params.empty?
  end

  def show
    render json: { status: STATUS_CODE[:ok], data: @task }, include: [:category]
  end

  def create
    @task = Task.new(task_params)
    @task.title = @task.title.strip
    @task.content = @task.content.strip
    @task.status = 1
    raise StandardError unless @task.title.length > 0
    @task.save!
    render json: { status: STATUS_CODE[:created], message: STATUS_MESSAGE[:create], data: @task }, status: :created
    rescue StandardError
      render json: { status: STATUS_CODE[:bad_request], message: STATUS_MESSAGE[:bad_request] }, status: :bad_request
  end

  def update 
    @task.update!(task_params)
    render json: {status: STATUS_CODE[:ok], message: STATUS_MESSAGE[:update]}, status: :ok
  end

  def update_status
    params.permit(:status)
    @task.update!(status: params[:status])
    render json: {status: STATUS_CODE[:ok], message: STATUS_MESSAGE[:update]}, status: :ok
  end

  def destroy
    @task.destroy!
    render json: { status: STATUS_CODE[:ok], message: STATUS_MESSAGE[:delete] }, status: :ok
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
