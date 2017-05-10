require("spec_helper")

describe(Employee) do
  it("can have a project") do
    test_employee1 = Employee.new(name: "Pilar Martinez")
    test_project = test_employee1.projects.new(name: "fix ruby lessons")
    expect(test_employee1.projects()).to(eq([test_project]))
  end

  it("can have multiple projects") do
    test_employee1 = Employee.new(name: "Pilar Martinez")
    test_project1 = test_employee1.projects.new(name: "fix ruby lessons")
    test_project2 = test_employee1.projects.new(name: "learn more ruby")
    expect(test_employee1.projects()).to(eq([test_project1,test_project2]))
  end
end
