module CandidatesHelper
  def candidate_option_text(candidate)
    "#{candidate.name} - #{candidate.email}"
  end
  def employee_option_text(employee)
    "#{employee.name} - #{employee.email}"
  end
end
