---
title: Drinking the Elixir
date: 2015-11-16 11:41 UTC
tags:
---

[Elixir](http://elixir-lang.org/) is a new and exciting open source programming language with scope to become [the next big language for the web](http://www.creativedeletion.com/2015/04/19/elixir_next_language.html). I'm here to evangelise and spread the word about Elixir.

## Erlang, the secret sauce

Elixir is built on top of the mature [Erlang](http://www.erlang.org/) virtual machine and inherits its best features. Erlang (itself a programming language) was originally developed in the 1980s by [Ericsson](https://en.wikipedia.org/wiki/Ericsson) for use in their telephone switches and has a history of stability in large scale distributed systems. The Erlang platform is widely considered to be [awesome](http://veldstra.org/whyerlang/), yet it has never gained mainstream adoption. Despite this, the platform has a number of desirable properties:

* **Concurrent** – Erlang has an [actor model](https://en.wikipedia.org/wiki/Actor_model) for concurrency where lightweight processes run in parallel sending messages to each other instead of mutating shared memory. This simplifies the development of concurrent applications, reduces the scope for error and allows for extreme scalability.
* **Distributed** – Processes can communicate easily across a distributed network of machines in the same way local processes do.
* **Fault-tolerant** – Errors will happen in any system. Erlang embraces this idea and enables developers to build systems that automatically recover from faults and self-heal.
* **Hot code deploy** – Erlang allows hot deployment of code into a running production system, without any downtime.
* **Battle proven** – Erlang has proven to scale. A notable example is [WhatsApp](http://www.fastcompany.com/3026758/inside-erlang-the-rare-programming-language-behind-whatsapps-success), the popular instant messaging service able to handle millions of connections on a single server.

## Introducing Elixir

Why use Elixir when Erlang is so awesome? Erlang is [weird](http://damienkatz.net/2008/03/what_sucks_abou.html). It has a strange syntax, a steep learning curve and dated tooling. Elixir solves this by building on the best of Erlang. It combines Erlang features like pattern matching and immutability with aspects from other languages:

* A natural syntax inspired by [Ruby](https://www.ruby-lang.org/).
* Lazy evaluation from [Haskell](https://www.haskell.org/).
* Protocols, macros and pipelines from [Clojure](http://clojure.org/).

Elixir does all of this really well too:

* **Functional programming** – A [functional](https://en.wikipedia.org/wiki/Functional_programming) style of programming promotes the development of concise, reusable and maintainable code. Combined with immutable data structures, the developer can more easily reason about the code.
* **Extensibility** – Most of Elixir is written in itself using the [metaprogramming](https://en.wikipedia.org/wiki/Metaprogramming) capability. This enables anyone to extend the language with its native tools by building [DSLs](https://en.wikipedia.org/wiki/Domain-specific_language) and macros.
* **Modern tooling** – A modern build tool, package manager, doc generator and testing framework all come with Elixir. The community continues to innovate here building [awesome tools and libraries](https://github.com/h4cc/awesome-elixir).
* **Full compatibility with Erlang** – Elixir projects can leverage the large ecosystem of existing Erlang libraries and invoke functions with no runtime cost.

The result of all of this is a truly modern, practical and performant language on a platform capable of supporting even the most ambitious projects.

## Phoenix rises

[Phoenix](http://www.phoenixframework.org/) is an amazing Elixir framework for building modern, real-time web applications. It gives developers a lightweight foundation to build applications with massive scalability.

Developers build with the familiar [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) pattern seen in frameworks like Rails and Django. But unlike these, Phoenix is fast. So fast it measures response times in microseconds instead of milliseconds. You don’t have to sacrifice performance for the sake of productivity. You *can* have your cake and eat it.

Phoenix is built for real-time, taking full advantage of Elixir's concurrency model. Technologies like [WebSockets](https://en.wikipedia.org/wiki/WebSocket) are supported out of the box, opening the door for a new type of web application.

With the help of Phoenix, Elixir is set to be the go-to language for the web and poised to kickstart a real-time web revolution.
