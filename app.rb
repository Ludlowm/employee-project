require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  erb(:index)
end

get("/employees") do
  @employees = Employee.all()
  erb(:employees)
end

get("/projects") do
  @projects = Project.all()
  erb(:projects)
end

post("/employees") do
  name = params.fetch("employee_name")
  Employee.create({:name => name})
  redirect("/employees")
end

post("/projects") do
  name = params.fetch("project_name")
  Project.create({:name => name})
  redirect("/projects")
end

get("/employees/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  @employee_projects = @employee.projects
  @unassigned_projects = Project.all.to_a.keep_if{|project| !@employee_projects.include?(project)}
  erb(:employee)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project_employees = @project.employees
  @unassigned_employees = Employee.all.to_a.keep_if{|employee| !@project_employees.include?(employee)}
  erb(:project)
end

patch("/employees/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  projects_to_add = params.fetch("projects_to_add",[])
  projects_to_delete = params.fetch("projects_to_delete",[])
  projects_to_add.each do |id|
    @employee.projects.push(Project.find(id))
  end
  projects_to_delete.each do |id|
    @employee.projects.destroy(Project.find(id))
  end
  redirect back
end

patch("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  employees_to_add = params.fetch("employees_to_add", [])
  employees_to_delete = params.fetch("employees_to_delete", [])
  employees_to_add.each do |id|
    @project.employees.push(Employee.find(id))
  end
  employees_to_delete.each do |id|
    @project.employees.destroy(Employee.find(id))
  end
  redirect back
end
