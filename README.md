# trackd
=======

Problem statement-
“Make a rails app to handle projects and tasks.
A logged in user can create projects, create tasks on it and assign the tasks to people.
Please feel free to add any functionality as per your choice
**We would love to see some tests “

Use-
Rails 7
Ruby 3

Steps to run after cloning repo-
rails db:drop db:create db:seed
You can login using a default user created in seed amit.k@example.com (Whitebox@123)

Entities
- User
    - first_name
    - last_name
    - email
    - password_digest
    - is_admin
- Project
    - title
    - code
    - description
    - project lead
- Task
    - summary
    - description
    - project
    - status
    - assignee

1. Controllers-
    1. sessions controller- Manage the session
    2. Tasks controller- CRUD for tasks
    3. Projects controller- CRUD for tasks


Status:

Done:
1. Create models, migrations and tests and validations
2. Create seed data for Users and a project and tasks under it
3. Create session controller and let users login using basic authentication (will convert to devise later if time permits)
4. After user logs in - Show user their tasks
    1. The task view should have a table with important attributes, and links for actions
    2. They have a create button on UI so they can create a task
    3. they can sort on relevant columns
5. Task edit and show- Add these actions and view. Write tests around these actions. Use the same form/view
6. For debugging and keeping important data in DB, add acts_as_paranoid and papertrail gem
7. Admin - create/edit projects
8. Add pundit policies for Projects controller


To Be Done
1) Add user and projects association
2) Change Task controller to have pundit policies according to associations
3) Admin - create/edit users
4) Analytics for tasks - Pie chart on the basis of status
5) Log all API requests to a table audit_trail, filter password parameter in audit requests


