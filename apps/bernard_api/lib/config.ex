defmodule BernardApi.Config do
  @moduledoc """
  Contains code for accessing configuration variables and other runtime
  configuration options
  """

  def get_environment_variable(name) do
    variable = System.get_env(name)
    variable || (raise "Environment variable " <> name <> " is missing")
  end
end
