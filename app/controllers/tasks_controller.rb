class TasksController < ApplicationController

  before_action :set_task, only: %i[ show update destroy ]

  def index
    render json: Task.all
  end

  def show
    render json: @task
  end

  def create
    @task = Task.new(task_params)
    @task.status = "In Progress"
    
    if @task.save
      render json: { status: 200, statusMessage: 'Create successfully', data: @task }
    else
      render json: @task.errors, status: :unprocessable_entity
    end

  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :startDate, :endDate)
  end
end
