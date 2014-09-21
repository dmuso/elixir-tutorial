defmodule Parallel do
  def pmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
end

result = Parallel.pmap 1..1000, &(&1 * &1)

# Not sure yet how to output result
# these attemps below only get me so far.

# IO.puts result
# ** (ArgumentError) argument error
#     (stdlib) :io.put_chars(#PID<0.23.0>, :unicode, [[1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324, 361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961, 1024, 1089, 1156, 1225, 1296, 1369, 1444, 1521, 1600, 1681, 1764, 1849, 1936, 2025, 2116, 2209, 2304, 2401, ...], 10])
#     (elixir) src/elixir_lexical.erl:17: :elixir_lexical.run/3
#     (elixir) lib/code.ex:316: Code.require_file/2

# IO.puts to_string result
# ** (UnicodeConversionError) invalid code point 55696
#     (elixir) lib/list.ex:560: List.to_string/1
#     pmap1.exs:11: (file)
#     (elixir) src/elixir_lexical.erl:17: :elixir_lexical.run/3
#     (elixir) lib/code.ex:316: Code.require_file/2

# IO.puts("result: #{result}")
# ** (UnicodeConversionError) invalid code point 55696
#     (elixir) lib/list.ex:560: List.to_string/1
#     pmap1.exs:10: (file)
#     (elixir) src/elixir_lexical.erl:17: :elixir_lexical.run/3
#     (elixir) lib/code.ex:316: Code.require_file/2