module SprintsHelper

  def team_status_table(teams, sprint_list, flags)
    content_tag(:table, class: "table") do
      concat(content_tag(:thead) do
        content_tag(:tr) do
          concat(content_tag(:th, "Team", scope: "col"))
          concat(sprint_header(sprint_list))
        end
      end)
      concat(content_tag(:tbody) do
        team_rows(teams, sprint_list, flags)
      end)
    end
  end

  def sprint_header(sprint_list)
    sprint_list.map do |sprint|
      content_tag(:th, sprint, scope: "col")
    end.join.html_safe
  end

  def team_rows(teams, sprint_list, flags)
    teams.map do |current_team|
      content_tag(:tr) do
        concat(content_tag(:th, current_team))
        concat(sprint_team_cells(teams, sprint_list, flags, current_team))
      end
    end.join.html_safe
  end

  def sprint_team_cells(teams, sprint_list, flags, current_team)
    sprint_list.map do |sprint|
      content_tag(:td) do
        content_tag(:div) do
          if flags[sprint][current_team].include?("student blank")
            icon, title = unfinished_sprint(teams, flags, sprint) ? ["question-circle-fill.svg", "This sprint has not yet concluded"] : ["exclamation-triangle-fill-red.svg", "All students failed to submit a survey"]
          elsif flags[sprint][current_team].empty?
            icon, title = ["check-circle-fill.svg", "All is well"]
          else
            icon, title = flag_icon_and_title(flags[sprint][current_team])
          end
          content_tag(:p, class: "p-0 m-0") do
            image_tag(icon, class: "", style: "height:16px", title: title)
          end
        end
      end
    end.join.html_safe
  end

  def flag_icon_and_title(flags)
    flags.each do |flag|
      case flag
      when "missing submit"
        return ["exclamation-triangle-fill-red.svg", "At least one of the students failed to submit a survey"]
      when "low score"
        return ["exclamation-triangle-fill-red.svg", "At least one of the students received an average rating lower than 4"]
      when "no client score"
        return ["exclamation-circle-fill-yellow.svg", "The client did not submit a survey"]
      when "low client score"
        return ["exclamation-triangle-fill-red.svg", "The client is unsatisfied"]
      end
    end
    ["", ""]
  end

  def unfinished_sprint(teams, flags, sprint)
    # Add the implementation for this method
  end
end
