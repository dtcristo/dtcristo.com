---
title: Just a sip of Eilixr
date: 2021-03-19 12:35 UTC
tags:
id: urn:uuid:5e6c4726-172e-4349-92c1-b0c61a0eb9e2
---

Elixir is a functional programming language I've been [excited](/drinking-the-elixir) by for some time. Here is a quick taste.

## Atoms (named constants)

```elixir
:foobar
#=> :foobar
```

## Lists

```elixir
[1, 2, 3, 4]
#=> [1, 2, 3, 4]

[1 | [2, 3, 4]]
#=> [1, 2, 3, 4]

[1 | [2 | [3 | [4 | []]]]]
#=> [1, 2, 3, 4]
```

## Tuples

```elixir
{:ok, "Go!"}
#=> {:ok, "Go!"}
```

## Strings and binaries

```elixir
"Héllö"
#=> "Héllö"

"Héllö" == <<72, 195, 169, 108, 108, 195, 182>>
#=> true

<<240, 159, 146, 156>>
#=> "💜"
```

## Keyword lists (ordered associative lists)

```elixir
list = [{:a, 1}, {:b, 2}]
#=> [a: 1, b: 2]

list == [a: 1, b: 2]
#=> true

list[:a]
#=> 1
```

## Maps

```elixir
map = %{:a => 1, 2 => :b}
#=> %{2 => :b, :a => 1}

map[2]
#=> :b

map[:c]
#=> nil
```

## Anonymous functions

```elixir
add = fn a, b -> a + b end

add = &(&1 + &2) # Shorthand

add.(2, 4)
#=> 6
```

## Pattern matching

```elixir
{a, b, c} = {:hello, "world", 42}
#=> {:hello, "world", 42}
a
#=> :hello
b
#=> "world"

{a, b, c} = {:hello, "world"}
#=> ** (MatchError) no match of right hand side value: {:hello, "world"}

{:ok, result} = {:ok, 13}
#=> {:ok, 13}
result
#=> 13

{:ok, result} = {:error, :oops}
#=> ** (MatchError) no match of right hand side value: {:error, :oops}

[head | tail] = [1, 2, 3]
#=> [1, 2, 3]
head
#=> 1
tail
#=> [2, 3]
```

## Modules and named functions

```elixir
defmodule HelloWorld do
  def greet(name) do
    IO.puts "Hello #{name}!"
  end
end

HelloWorld.greet("World")
#stdout> Hello World!
#=> :ok
```

## Recursion

```elixir
defmodule Fibonacci do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) when n > 1, do: fib(n-1) + fib(n-2)
end

Fibonacci.fib(10)
#=> 55

Fibonacci.fib(-4)
#=> ** (FunctionClauseError) no function clause matching in Fibonacci.fib/1
```

## Map function

```elixir
defmodule ListOps do
  def map([], _f), do: []
  def map([head | tail], f) do
    [f.(head) | map(tail, f)]
  end
end

ListOps.map([1, 2, 3], &(&1 * 3))
#=> [3, 6, 9]
```

## `Enum.map` and `Enum.reduce`

```elixir
Enum.map([1, 2, 3], &(&1 * 3))
#=> [3, 6, 9]

Enum.reduce([1, 2, 3], 0, fn(x, acc) -> x + acc end)
#=> 6

[1, 2, 3]
|> Enum.map(&(&1 * 3))
|> Enum.reduce(0, fn(x, acc) -> x + acc end)
#=> 18
```

## Pipe operator (`|>`)

```elixir
Enum.take(Enum.filter(Enum.map(1..1_000_000, &(&1 * 3)), &Integer.is_odd/1), 10)
#=> [3, 9, 15, 21, 27, 33, 39, 45, 51, 57]

1..1_000_000
|> Enum.map(&(&1 * 3))
|> Enum.filter(&Integer.is_odd/1)
|> Enum.take(10)
#=> [3, 9, 15, 21, 27, 33, 39, 45, 51, 57]
```

## Stream module (lazy enumerables)

```elixir
1..1_000_000
|> Stream.map(&(&1 * 3))
|> Stream.filter(&Integer.is_odd/1)
|> Enum.take(10)
#=> [3, 9, 15, 21, 27, 33, 39, 45, 51, 57]
```

## Processes

```elixir
defmodule PingPong do
  def await(count) do
    new_count = count + 1
    receive do
      {:ping, caller} -> send(caller, {:pong, new_count})
    end
    await(new_count)
  end
end

pid = spawn(PingPong, :await, [0])
#=> #PID<0.94.0>

send(pid, {:ping, self})
#=> {:ping, #PID<0.59.0>}

flush
#stdout> {:pong, 1}
#=> :ok
```

## Task (run asynchronous job)

```elixir
task = Task.async(fn -> :some_result end)
#=> %Task{pid: #PID<0.211.0>, ref: #Reference<0.0.2.334>}

Task.await(task)
#=> :some_result
```

## Agent (store state)

```elixir
{:ok, pid} = Agent.start(fn -> %{} end)
#=> {:ok, #PID<0.72.0>}
Agent.update(pid, fn map -> Map.put(map, :key, "value") end)
#=> :ok
Agent.get(pid, fn map -> Map.get(map, :key) end)
#=> "value"
```

## Quoted expressions (AST)

```elixir
quote do: sum(1, 2, 3)
#=> {:sum, [], [1, 2, 3]}

quote do: 1 + 2
#=> {:+, [context: Elixir, import: Kernel], [1, 2]}

Macro.to_string({:+, [context: Elixir, import: Kernel], [1, 2]})
#=> "1 + 2"

quote do: sum(1, 2 + 3, 4)
#=> {:sum, [], [1, {:+, [context: Elixir, import: Kernel], [2, 3]}, 4]}

inner = [3, 4, 5]
Macro.to_string(quote do: [1, 2, unquote(inner), 6])
#=> "[1, 2, [3, 4, 5], 6]"
```

## Macros

```elixir
defmacro unless(expr, opts) do
  quote do
    if(!unquote(expr), unquote(opts))
  end
end

unless true do
  IO.puts "this will never be seen"
end
```

```elixir
defmodule MyMacro do
  defmacro twice(block) do
    quote do
      IO.puts "About to do something twice"
      unquote(block)
      unquote(block)
    end
  end
end

import MyMacro

twice do
  IO.puts "Hi there!"
end
#stdout> About to do something twice
#stdout> Hi there!
#stdout> Hi there!
```
