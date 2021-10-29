---
layout: post
title: "K#0001: Idea Based Programming (aka Platonic Typing)"
author: Cade Brown
email: me@cade.site
categories: [kata]
tags: [lang, types]
series: types
thumb: /files/src/K0001/types_all.dot.webp
---

buckle up! we're about to dive into the world of math, programming, and language. particularly, how they interact and how they can be used in Kata via Idea Based Programming (aka Platonic Typing). i'm going to also explain some other type systems, and some problems that arise from using them.

<!--more-->

## Type Systems & Semantics

when we talk about programming, we (primarily) talk about ideas. for example, when we program on whiteboards using [psuedocode](https://en.wikipedia.org/wiki/Pseudocode), loose definitions of types and functions are used. we don't care about the actual implementation, we care about the semantics of the code (i.e. the underlying transformations between values). 

i've noticed that whiteboard programming is the best way to convey ideas to colleagues when we're working on a difficult problem, because all the "noise" in most programming languages is gone. when you understand a whiteboard full of psuedocode, the distance between math, computer science, and normal language (in our case, English) is reduced by an order of magnitude. 



### Classic Approaches

with most programming languages, there is a coupling between the abstract ideas, and the datastructures used to implement them. for example, in C the abstract idea of a `list` of some type `T` cannot be expressed - a concrete data structure must be used. this is problematic for a few reasons:

  * there is no default implementation available, so a library or custom implementation must be used
  * switching between different implementations is difficult
  * a particular implementation may be inefficient on different hardware
  * the idea is not composable (i.e. having a list of lists is difficult...)

of course, C is a very old language and is not meant to be a very high level language. even C++ fixes many of these problems with its templating system although, arguably, it creates many more:

  * there is still the problem of switching between different implementations (i.e. if you use `std::vector<T>` everywhere it is still a specific implementation)
  * since the template system is ad-hoc, it is very unnatural to use. you have to jump through hoops that aren't intuitive or fundamental to the operation you're trying to do
  * for more complex types/models, multiple inheritance is required
    * this can degrade performance, as it requires virtual method dispatching

going further, C# (aka (C++)++) fixes these (and provides a syntax with more forethought). in C#, multiple inheritance is outlawed, and [interfaces](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/types/interfaces) are used to organize functionality. a single type can implement multiple interfaces, but can only derive from 1 super type (i.e. single inheritance).

this means that:

  * the type hierarchy is a tree (as opposed to C++, which is a directed acyclic graph (DAG))
  * the interface hierarchy is a DAG (i.e. there can't be a cycle of interfaces)

as a result, no multiple inheritance dispatch is required, as concrete types always have a single dispatch table (this means it can be more efficient at runtime)

so, we're done, right? surely a DAG interface hierarchy on top of a tree type hierarchy is suitable for a modern programming language...

### Dynamic Approaches

many modern languages with vastly different approaches to type systems have arisen. many, however, are probably too dynamic, or are implemented in a way that makes it impossible to write efficient and robust code.

#### Python

[Python](https://www.python.org), for example, is a duck-typed language that also supports multiple inheritance. instead of using dispatch tables (like C++), it traverses the supertypes(s) at runtime using [MRO](http://python-history.blogspot.com/2010/06/method-resolution-order.html). of course, Python code is typically slow even without using multiple inheritance... so, when the runtime is having to search the tree of types each time a method/attribute is used, it can slow your code down considerably.

things are complicated further when you realize that the existence of duck-typing and multiple inheritance in Python is kind of redundant; shouldn't they just stick to one scheme or the other for polymorphism? after all, the [Zen of Python](https://www.python.org/dev/peps/pep-0020/) says that "There should be one-- and preferably only one --obvious way to do it"... and yet there are 2 ways to do it, neither of which obvious or complete

i don't think Python should be our "success story" for modern languages...

#### Lua (and LuaJIT)

Lua ([LuaJIT](https://luajit.org/)) solves the typing problem a very interesting way: simply restrict the list of all types to a set of known types (specifically, there are [7 types](https://www.lua.org/manual/2.2/section3_3.html)). this means that the type system is a static type system, and the runtime can be optimized to use a single dispatch table. however, it has the restriction that no custom types can be defined.

so, although Lua is very fast, it can't really do everything you'd want out of a general purpose programming language (although, it's very useful for scripting when you need performance)

#### Julia

a language that stands out is [Julia](https://julialang.org/). although Julia is a high level dynamic language it can be just as fast as native code, and is being used for High Performance Computing (HPC) and Data Science (check their [benchmarks](https://julialang.org/benchmarks/)). 

what?? i was **just** told that performance comes from static type systems! how is Julia achieving this performance while allowing for dynamic type systems?

![Julia benchmarks](https://julialang.org/assets/benchmarks/benchmarks.svg){: .img-S }

the answer is basically that Julia has a very unique [type system](https://docs.julialang.org/en/v1/manual/types/) that is exploited by its runtime:

  * most types are abstract, and cannot be instantiated directly
  * types that can be instantiated are called concrete types, and all concrete types are final/[sealed (C#)](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/sealed) (which means no subtypes can be created)
    * therefore, the type hierarchy for *real* objects is just a single concrete type

this restriction of interfaces/abstract types to a DAG, while concrete types are final, allows for a very efficient implementation of the type system using a JIT (Just-In-Time) compiler (some people call it JAOT (Just-Ahead-Of-Time) compiler)

since the type can be exactly known, and it is known that no subtypes are allowed, there is no need to dispatch to a virtual method. the JIT compiler can directly call the method defined on the concrete type. this means the function can be inlined, or translated to a direct call without any indirection. it also means that values can be unboxed and optimized/inlined during code generation

now, we must **really** be done... right?


### Kata's Approach

Kata's approach to types is different than 

![type graph (all)](/files/src/K0001/types_all.dot.webp){: .img-L }

TODO: explain it

