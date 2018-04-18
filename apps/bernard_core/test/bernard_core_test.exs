defmodule BernardCoreTest do
  use ExUnit.Case
  doctest BernardCore

  test "greets the world" do
    assert BernardCore.hello() == :world
  end
end
