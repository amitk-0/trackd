require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  fixtures :tasks
  fixtures :users
  fixtures :projects

  setup do
    @task1 = tasks(:task_one)
    tasks(:task_two)
    tasks(:task_three)
    tasks(:task_in_progress)
    @user = @task1.created_by
    @user.update(password: 'ComplexPwd123')
    post login_url, params: { email: @user.email, password: 'ComplexPwd123' }
  end

  test 'should get index with only own tasks' do
    get tasks_url
    assert_response :success
    assert_not_nil assigns(:tasks)
    assert_equal 3, assigns(:tasks).count
  end

  test 'should sort tasks based on status' do
    get tasks_url, params: { sort: 'status', direction: 'desc' }
    assert_response :success
    assert_not_nil assigns(:tasks)
    tasks = assigns(:tasks)
    assert_equal 'in_progress', tasks.first.status
  end

  test 'should get new' do
    get new_task_url
    assert_response :success
    assert_not_nil assigns(:task)
  end

  test 'should create task' do
    project = projects(:project_one)
    user = User.create(first_name: 'Abc', last_name: 'pqr', email: 'abc.pqr@example.com')
    assert_difference 'Task.count', 1 do
      post tasks_url, params: { task: { summary: 'Create new dashboard for marketing',
                                        description: 'For new year sales target, create new dashboard for marketing',
                                        project_id: project.id,
                                        assignee_id: user.id,
                                        status: 'to_do' }
      }
    end

    assert_redirected_to tasks_path do |redirect|
      assert_equal 'The task was created successfully', flash[:notice]
    end
  end

  test 'should give error when unable to create task' do
    project = projects(:project_one)
    user = User.create(first_name: 'Abc', last_name: 'pqr', email: 'abc.pqr@example.com')
    assert_difference 'Task.count', 0 do
      post tasks_url, params: { task: { summary: 'Bring all things together',
                                        description: 'short',
                                        project_id: project.id,
                                        assignee_id: user.id,
                                        status: 'to_do' }
      }
    end

    assert_equal 'Error while creating task - Description is too short (minimum is 15 characters)', flash[:notice]
  end

  test 'should get edit' do
    get edit_task_path(id: @task1.id)
    assert_response :success
    task = assigns(:task)
    assert_equal task.id, @task1.id
  end

  test 'should update task' do
    patch task_path(@task1), params: { task: { summary: 'changed summary',
                                      description: @task1.description,
                                      project_id: @task1.project_id,
                                      assignee_id: @task1.assignee_id,
                                      status: 'done' }
    }
    assert_redirected_to edit_task_path(@task1) do |redirect|
      assert_equal 'The task was updated successfully', flash[:notice]
    end
    @task1.reload
    assert_equal @task1.summary, 'changed summary'
  end

  test 'should get all tasks when admin' do
    @user.update(is_admin: true)
    get '/all_tasks'
    assert_response :success
    assert_equal assigns(:tasks).count, 4
  end

  test 'should not get all tasks when non-admin' do
    @user.update(is_admin: false)
    get '/all_tasks'
    assert_redirected_to root_path do |redirect|
      assert_equal 'Information you requested, either does not exist or is not authorized for access.', flash[:error]
    end
    assert_nil assigns(:tasks)
  end

end
