require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest

  setup do
    @task = tasks(:one) 
  end

  test "should get all tasks" do
    get tasks_url, as: :json
    assert_response :success
  end

  test "should show specific task" do
    get task_url(@task), as: :json
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { title: "Me", content: "me", startDate: "2024-07-16T07:45:22.900Z", endDate: "2024-07-20T07:45:22.900Z" }}, as: :json
    end
    assert_response :success
  end
end
