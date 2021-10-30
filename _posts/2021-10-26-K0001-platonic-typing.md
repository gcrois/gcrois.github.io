---
layout: post
title: "K#0001: Kata's Type System: Platonic Typing"
author: Cade Brown
email: me@cade.site
categories: [kata]
tags: [lang, types]
series: types
thumb: /files/src/K0001/types_all.dot.webp
---

buckle up! we're about to dive into the world of math, programming, and language. particularly, how they interact and how they can be used in Kata via Platonic Typing. i'm going to also explain some other type systems, and some issues that arise when using them.

<!--more-->


## First, An Aside

let me start by introducing an excerpt from a dialogue between Parmenides and Socrates:

> **Parmenides**: if you say that things participate in ideas, must you not say either that everything is made up of thoughts, and that all things think; or that there are thoughts but have no thought?
>
> **Socrates**: in my opinion, the ideas are patterns fixed in nature, and other things are like them, and resemblances of them -- what is meant by the participation of other things in the ideas, is really assimilation to them.
>
> -- in [*Parmenides*](https://en.wikipedia.org/wiki/Parmenides_(dialogue)) by [Plato](https://en.wikipedia.org/wiki/Plato). 


if you're unfamiliar or need a refresher on what Platonism is, here's a good definition (emphasis mine):

> Platonism about mathematics (or mathematical platonism) is the metaphysical view that there are **abstract mathematical objects whose existence is independent** of us and our language, thought, and practices. 
> 
> **Just as electrons and planets exist independently of us, so do numbers and sets**. And just as statements about electrons and planets are made true or false by the objects with which they are concerned and these objects’ perfectly objective properties, so are statements about numbers and sets. 
>
> **Mathematical truths are therefore discovered, not invented.**
>
> -- Stanford, [*Platonism in the Philosophy of Mathematics*](https://plato.stanford.edu/entries/platonism-mathematics/)


try to keep this in mind, as we'll revisit this later in the post. specifically, try to apply it to programming languages, concepts, and objects. 


## Type Systems, Semantics

when we talk about programming, we (primarily) talk about concepts. for example, when we program on whiteboards using [psuedocode](https://en.wikipedia.org/wiki/Pseudocode), loose definitions of types and functions are used. we don't care about the actual implementation, we care about the semantics of the code (i.e. the underlying processes and algorithms). we could say that we are working in a **top down** fashion.

however, when we're programming in a language, we're usually dealing with an actual implementation. we typically tie functionality directly to the name we choose for a given concept. in this case, programmers are typically working in a **bottom up** fashion. for example, most object-oriented type systems with inheritance are bottom up, since we start with nothing and build up to more specific types.

i've noticed that whiteboard programming is the best way to convey ideas to colleagues when we're working on a difficult problem, because all the "noise" in most programming languages is gone. when you understand a whiteboard full of psuedocode, the distance between math, computer science, and normal language (in our case, English) is reduced by (at least) an order of magnitude. as a result it takes less time to:

  * write/describe an algorithm
  * understand psuedocode written by someone else

if only there was some way to succinctly represent that in a way that would actually run :P... but before we can describe such a system, let's remind ourselves of some existing type systems that are being used my millions of programmers in the world today:

### C, C++, C# (3 generations of bottom-up design)

with most programming languages, there is a coupling between the abstract ideas, and the datastructures used to implement them. for example, in C the abstract idea of a `list` of some type `T` cannot be expressed -- a specific concrete data structure must be used. this is problematic for a few reasons:

  * there is no default implementation available, so a library or custom implementation must be used. any particular implementation may:
    * be slow/inefficient for some types or all, or for different hardware
    * have bugs present
    * be incompatible with other implementations
    * choose odd/non-standard names which is less readable, invites bugs, and slows development
  * switching between different implementations is difficult
  * the idea is not composable (i.e. having a list of lists is difficult...)

of course, C is an old language and is not meant to be a very high level language. even C++ fixes many of these problems with its templating system although, arguably, it creates many more:

  * there is still the problem of switching between different implementations (i.e. if you use `std::vector<T>` everywhere it is still a specific implementation)
  * since the template system is ad-hoc, it is very unnatural to use and has odd syntax. you have to jump through hoops that aren't intuitive or fundamental to the operation you're trying to do
    * this also results in indecipherable error messages, slowing development
  * for more complex types/models, multiple inheritance is required
    * this can degrade performance, as it requires virtual method dispatching

going further, C# (aka (C++)++) fixes these (and provides a syntax with more forethought). in C#, multiple inheritance is outlawed, and [interfaces](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/types/interfaces) are used to organize functionality. a single type can implement multiple interfaces, but can only derive from 1 super type (i.e. single inheritance).

this means that:

  * the type hierarchy is a tree (as opposed to C++, which is a directed acyclic graph (DAG))
  * the interface hierarchy is a DAG (i.e. there can't be a cycle of interfaces)
    * don't ask me how i found out...

as a result, no multiple inheritance dispatch is required, so concrete types always have a single dispatch table (this means it can be more efficient at runtime)

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

![Julia benchmarks](https://julialang.org/assets/benchmarks/benchmarks.svg){: .img-M .bk-inv }

what?? i was **just** told that performance comes from static type systems! how is Julia achieving this performance while allowing for dynamic type systems?

the answer is basically that Julia has a [unique type system](https://docs.julialang.org/en/v1/manual/types/) that is exploited by its runtime:

  * most types are abstract, and cannot be instantiated directly
  * types that can be instantiated are called concrete types, and all concrete types are final/[sealed (C#)](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/sealed) (which means no subtypes can be created)
    * therefore, the type hierarchy for *real* objects is just a single concrete type

this restriction of interfaces/abstract types to a DAG, while concrete types are final, allows for a very efficient implementation of the type system using a JIT (Just-In-Time) compiler (some people call it JAOT (Just-Ahead-Of-Time) compiler)

since the type can be exactly known, and it is known that no subtypes are allowed, there is no need to dispatch to a virtual method. the JIT compiler can directly call the method defined on the concrete type. this means the function can be inlined, or translated to a direct call without any indirection. it also means that values can be unboxed and optimized/inlined during code generation

now, we must **really** be done... right?


### Kata's Approach

Kata's approach to types is different than all the aforementioned languages, although it is most similar to Julia's. Kata's type system is based on [mathematical platonism](https://en.wikipedia.org/wiki/Philosophy_of_mathematics#Platonism). you can read about more about [Kata's philosophy at /philosophy](/philosophy), but in terms of traditional type systems, Kata's can be described as:

  * most types are abstract, and cannot be instantiated directly
  * concrete types that can be instantiated are final/sealed, thus they never have concrete supertypes (only abstract ones)
  * a large graph of mathematical concepts and interfaces is used to define the type system

however, 

  * Kata's abstract types are called "concepts", and can be thought of as a collection of properties, operations, and related concepts
  * Kata's abstract types can be mutually recursive (i.e. a concept can be a superconcept of itself)
    * there can be arbitrary cycles, self-loops, and multiple inheritance within the abstract world

i refer to any type system that follows these principles as having "Platonic Typing" rules. within individual Kata languages (KataCompiled, KataScript, etc), concepts and implementations can be shared freely through different syntaxes that may be better suited for certain purposes. 

while the builtin concepts (like `list[T]`, `dict[K,V]`, and so on) describe most useful types and cover >90% of everyday development tasks, more concepts can be invented for a particular purpose that extend or specializes existing ones. take, for example, the study of biology -- it may require types for the concept of a gene, the concept of a protein, and the concept of a cell, which may interact with existing structures and ideas. the very basis of Kata's type system is this graph of concepts and their interactions, which can be understood by an abstract model of computation.

then, a small bootstrapping phase is required to implement some concrete types and objects that can be run on an actual physical machine. conceptually, though, code is being compiled by a mechanical mind, and ran in a digital simulation.

PLATO (Platform/Language Agnostic Typed Ontology)

![type graph (all)](/files/src/K0001/types_all.dot.webp){: .img-L }


```plato
# collatz.kc

# here, we declare a singleton type template 'CollatzGraph[T]'
# this implements the singleton pattern and allows us
single CollatzGraph[T] is graph[T is int] {

  seen: cache[T,bool]

  # ret edges from 'n'
  func edges(n: T)->iter[T] {
    if n % 2 == 0, ret [n // 2]

    ret [3 * n + 1]
  }

  # ret whether 'n' passes the collatz test (i.e. ends up at '1')
  func check(n: T)->bool @CacheLRU {
    # check if 'n' is in the depth first search
    ret (this.dfs(n) as iter[T]).contains(1)
  }
}

# get a reference to the singleton for a collatz graph
g: CollatzGraph[u32] = default

# now, check 1 through 10 (these should all print 'yes')
for n in range(1, 10) {
  print($'{n}: {g.check(n)}')
}

# now, import modules for graph vizualization
import graphviz
import kos.fs

# write to a text file, which can be rendered online
# for example, paste in this website: https://dreampuf.github.io/GraphvizOnline/
with fp = kos.fs.open('collatz.dot', 'T') {
  # this will render the graph to a text file, showing all traversals required
  #   to determine that 1 through 10 pass the collatz test
  fp.write(graphviz.dot(g, range(1, 10)))
}

```