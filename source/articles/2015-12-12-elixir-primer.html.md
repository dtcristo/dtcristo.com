---
title: "Elixir primer: Part 1"
date: 2015-12-12 02:41 UTC
tags:
id: uri:uuid:5e6c4726-172e-4349-92c1-b0c61a0eb9e2
published: false
---

I've been [excited](/drinking-the-elixir) by Elixir for some time and today I'm going to give a primer into its friendly syntax and powerful semantics. After this, you should be up to speed with most of the basic concepts and be excited to learn more.

If you want to follow along with the examples, you can [install](http://elixir-lang.org/install.html) Elixir and run the code in the `iex` interactive console.

## Basic types
Along with common data types like integers, floats and booleans, Elixir has a number of unique types.

### Atoms
Atoms are just like symbols in Ruby and represent a constant where their name is their value.

```elixir
# Atom
:foobar
```

### Lists
Linked lists are very common in Elixir and used to store any ordered data. The pipe `|` character separates the head (front) and tail (rest) of the list where the head is a value and the tail is just another list. The following example shows three identical lists and the pipe character highlights the recursive nature of a list. In the third example `[]` is just an empty list used to indicate the end.

```elixir
# List
[1, 2, 3, 4]
[1 | [2, 3, 4]]
[1 | [2 | [3 | [4 | []]]]]
```

### Tuples
Tuples are like a lists but hold a known number of elements. Tuples are more performant than lists for random access.

```elixir
# Tuple
{:ok, "Go!"}
```

### String (Binary)

Strings literals can be represented in quotes or by their Unicode code points.

```elixir
"Héllö"
#=> "Héllö"

<<72, 195, 169, 108, 108, 195, 182>>
#=> "Héllö"
```

Elixir's Unicode support is first class and it does `upcase` better than Ruby.

```elixir
String.upcase("Héllö") # Elixir
#=> "HÉLLÖ"

"Héllö".upcase         # Ruby
#=> "HéLLö"
```

### Keyword lists
A keyword list is simply a regular list of 2-item tuples where the first element of each tuple is an atom.

```elixir
list = [{:a, 1}, {:b, 2}]
#=> [a: 1, b: 2]
```
Keyword lists are quite common so have their own shorthand syntax.

```elixir
list == [a: 1, b: 2]
#=> true
```
Key values can be accessed with the following syntax.

```elixir
list[:a]
#=> 1
```

### Maps

```elixir
map = %{:a => 1, 2 => :b}
#=> %{2 => :b, :a => 1}

map[2]
#=> :b

map[:c]
#=> nil
```

### Anonymous functions

```elixir
add = fn a, b -> a + b end

add = &(&1 + &2) # Shorthand

add.(2, 4)
#=> 6
```

### Pattern matching

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

### Modules and named functions

```elixir
defmodule HelloWorld do
  def greet(name) do
    IO.puts "Hello #{name}!"
  end
end

HelloWorld.greet("Hardhat")
#stdout> Hello Hardhat!
#=> :ok
```

### Recursion

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

### Map function

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

### `Enum.map` and `Enum.reduce`

```elixir
Enum.map([1, 2, 3], &(&1 * 3))
#=> [3, 6, 9]

Enum.reduce([1, 2, 3], 0, fn(x, acc) -> x + acc end)
#=> 6

[1, 2, 3]
|> Enum.map([1, 2, 3], &(&1 * 3)) | > Enum.reduce([1, 2, 3], 0, fn(x, acc) -> x + acc end)
```

### Pipe operator

```elixir
1..1_000_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(&Integer.is_odd/1) |> Enum.take(10)
#=> [3, 9, 15, 21, 27, 33, 39, 45, 51, 57]

1..1_000_000
|> Enum.map(&(&1 * 3))
|> Enum.filter(&Integer.is_odd/1)
|> Enum.take(10)
#=> [3, 9, 15, 21, 27, 33, 39, 45, 51, 57]

Enum.take(Enum.filter(Enum.map(1..1_000_000, &(&1 * 3)), &Integer.is_odd/1), 10)
#=> [3, 9, 15, 21, 27, 33, 39, 45, 51, 57]
```

### Stream module

```elixir
1..1_000_000
|> Stream.map(&(&1 * 3))
|> Stream.filter(&Integer.is_odd/1)
|> Enum.take(10)
#=> [3, 9, 15, 21, 27, 33, 39, 45, 51, 57]
```

### Processes

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

### Task (Run asynchronous job)

```elixir
task = Task.async(fn -> :some_result end)
#=> %Task{pid: #PID<0.211.0>, ref: #Reference<0.0.2.334>}
Task.await(task)
#=> :some_result
```

### Agent (Store state)

```elixir
{:ok, pid} = Agent.start(fn -> %{} end)
#=> {:ok, #PID<0.72.0>}
Agent.update(pid, fn map -> Map.put(map, :key, "value") end)
#=> :ok
Agent.get(pid, fn map -> Map.get(map, :key) end)
#=> "value"
```

### Quoted expressions (AST)

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

### Macros

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

So that's just a short into to Elixir
