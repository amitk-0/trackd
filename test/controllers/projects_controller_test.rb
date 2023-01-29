require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :projects
  fixtures :tasks

  setup do
    @project1 = projects(:project_one)
    projects(:project_two)
    @user = users(:user_admin)
    @user.update(password: 'AdminPwd123', is_admin: true)
    post login_url, params: { email: @user.email, password: 'AdminPwd123' }
  end

  test 'should get index' do
    get projects_url
    assert_response :success
    assert_not_nil assigns(:projects)
    assert_equal 2, assigns(:projects).count
  end

  test 'should not get index for non-admin' do
    @user.update(is_admin: false)
    get projects_url
    assert_redirected_to root_path
    assert_nil assigns(:projects)
  end

  test 'should get new' do
    get new_project_url
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test 'should create project' do
    user = User.create(first_name: 'Abc', last_name: 'pqr', email: 'abc.pqr@example.com')
    assert_difference 'Project.count', 1 do
      post projects_url, params: { project: { title: 'Trade Desk',
                                              code: 'TD',
                                              description: 'For activities related to large investments',
                                              project_lead_id: user.id
        }
      }
    end

    assert_redirected_to projects_path do |redirect|
      assert_equal 'The project was created successfully', flash[:notice]
    end
  end

  test 'should give error when unable to create project' do
    user = User.create(first_name: 'Abc', last_name: 'pqr', email: 'abc.pqr@example.com')
    assert_difference 'Project.count', 0 do
      post projects_url, params: { project: { title: 'Trade Desk',
                                              code: 'Too long code',
                                              description: 'For activities related to large investments',
                                              project_lead_id: user.id
        }
      }
    end

    assert_equal 'Error while creating project - Code is too long (maximum is 6 characters)', flash[:notice]
  end

  test 'should get edit' do
    get edit_project_path(id: @project1.id)
    assert_response :success
    assert_equal assigns(:project).id, @project1.id
  end

  test 'should not get edit when non-admin' do
    @user.update(is_admin: false)
    get edit_project_path(id: @project1.id)
    assert_redirected_to root_path do |redirect|
      assert_equal 'Information you requested, either does not exist or is not authorized for access.', flash[:error]
    end
  end

  test 'should update project' do
    patch project_path(@project1), params: { project: { title: 'changed project title' } }
    assert_redirected_to edit_project_path(@project1) do |redirect|
      assert_equal 'The project was updated successfully', flash[:notice]
    end
    @project1.reload
    assert_equal @project1.title, 'changed project title'
  end

  test 'should give error when not able to update project' do
    prev_title = @project1.title
    patch project_path(@project1), params: { project: { title: 'ab' } }
    assert_redirected_to edit_project_path(@project1) do |redirect|
      assert_equal 'Error while updating project', flash[:notice]
    end
    @project1.reload
    assert_equal @project1.title, prev_title
  end

  test 'should not update when non-admin' do
    @user.update(is_admin: false)
    patch project_path(@project1), params: { project: { title: 'changed project title' } }
    assert_redirected_to root_path do |redirect|
      assert_equal 'Information you requested, either does not exist or is not authorized for access.', flash[:error]
    end
  end

  test 'should get project tasks when admin' do
    get "/projects/project_tasks/#{@project1.id}"
    assert_response :success
    assert_equal assigns(:tasks).count, 1
  end

  test 'should not get project tasks when non-admin' do
    @user.update(is_admin: false)
    get "/projects/project_tasks/#{@project1.id}"
    assert_redirected_to root_path do |redirect|
      assert_equal 'Information you requested, either does not exist or is not authorized for access.', flash[:error]
    end
    assert_nil assigns(:tasks)
  end

end
