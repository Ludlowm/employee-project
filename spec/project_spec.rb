require("spec_helper")

describe(Project) do
  it("can have an employee") do
    test_project = Project.new(name: "Ruby lessons")
    test_employee = test_project.employees.new(name: "Ralph Poren")
    expect(test_project.employees()).to(eq([test_employee]))
  end

  it("can have multiple employees") do
    test_project = Project.new(name: "Ruby lessons")
    test_employee1 = test_project.employees.new(name: "Ralph Poren")
    test_employee2 = test_project.employees.new(name: "Bob Barley")
    expect(test_project.employees()).to(eq([test_employee1,test_employee2]))
  end
end
