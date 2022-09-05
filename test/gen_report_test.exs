defmodule GenReportTest do
  use ExUnit.Case

  alias GenReport
  alias GenReport.Support.ReportFixture

  @file_name "gen_report.csv"

  describe "build/1" do
    test "When passing file name return a report" do
      response = GenReport.build(@file_name)

      assert response == ReportFixture.build()
    end

    test "When no filename was given, returns an error" do
      response = GenReport.build()

      assert response == {:error, "Insira o nome de um arquivo"}
    end
  end

  describe "build_from_many/1" do
    test "When passing filenames, returns a report from all of them" do
      filenames = ["reports/part_1.csv", "reports/part_2.csv", "reports/part_3.csv"]

      response = GenReport.build_from_many(filenames)

      assert response == ReportFixture.build()
    end

    test "When given invalid input, returns an error" do
      response = GenReport.build_from_many("banana")

      expected_response = {:error, "Invalid input, should be a list of strings"}

      assert response == expected_response
    end
  end
end
