defmodule GenReport do
  alias GenReport.Parser

  def build, do: {:error, "Insira o nome de um arquivo"}

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(initial_report(), fn line, report -> update_report_with_line(report, line) end)
  end

  defp update_report_with_line(report, [name, hours, _day, month, year]) do
    all_hours = Map.update(report["all_hours"], name, hours, &(&1 + hours))

    hours_per_month =
      Map.update(
        report["hours_per_month"],
        name,
        %{month => hours},
        &update_hours_per_month(&1, hours, month)
      )

    hours_per_year =
      Map.update(
        report["hours_per_year"],
        name,
        %{year => hours},
        &update_hours_per_year(&1, hours, year)
      )

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp update_hours_per_month(hours_per_month, hours, month) do
    Map.update(hours_per_month, month, hours, &(&1 + hours))
  end

  defp update_hours_per_year(hours_per_year, hours, year) do
    Map.update(hours_per_year, year, hours, &(&1 + hours))
  end

  defp initial_report do
    %{
      "all_hours" => %{},
      "hours_per_month" => %{},
      "hours_per_year" => %{}
    }
  end
end
