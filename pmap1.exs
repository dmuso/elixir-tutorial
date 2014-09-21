defmodule Parallel do
  def pmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
  # pp from: http://joearms.github.io/2013/05/31/a-week-with-elixir.html
  def pp(x) do
    :io_lib.format("~p", [x])
    |> :lists.flatten
    |> :erlang.list_to_binary
  end
end

result = Parallel.pmap 1..1000, &(&1 * &1)

IO.puts ("#{Parallel.pp(result)}")

