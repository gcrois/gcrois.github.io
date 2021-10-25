---
layout: page
title: Philosophy
permalink: /philosophy
use_jquery: true
use_prism: true
---

Kata is designed with a unified philosophy in mind, that covers its design and usage.

  * hardware will continue to change, so maintainable software should be completely decoupled
  * different languages should be able to interact, so type systems and standard modules should be shared as much as possible
  * encapsulation, dependency management, and package distribution should be a part of the ecosystem, and never an after thought

## Comparisons


### "Why Not Language {X, Y, Z}?"

  * C: great for portability and performance, but severely lacking in composition, type systems, and the syntax has too many quirks
  * C#: a very well designed language, but within the larger .NET/CLR ecosystem (which is theoretically cross platform, but mysteriously very few apps written in it ever end up running outside of Windows...), and leans too much into the C-style syntax and pure-academic object-oriented programming paradigms
    * i know things like F# and other .NET languages are easy-interop with each other, but they weren't designed to truly be platform agnostic and web-oriented, which are now major use cases
  * Python: great for high level problem solving, "driver" code (as opposed to "engine"), but syntax is terrible (relevant whitespace, TitleCase constants, abuse of `:`, weird naming conventions, awkward syntax for `lambda`, the list goes on). Also, the standard library is just... not designed well. So many quirks, inconsistencies, and odd formulations (not to mention "hello, world" breaking!)
  * JavaScript: Come on now... i'm not going to even mention why JavaScript is not the one...

the above were only languages i consider myself fluent in (5+ years) and still use regularly. The following are languages i haven't used, or stopped using for one reason or another:

  * Rust: [it's difficult to learn](https://vorner.github.io/difficult.html). at least 90% of developers that i've known have tried it complain about the difficulty. it's poorly designed, and difficult to write non-linear programs with the borrow-checker
  * TypeScript/CoffeeScript/AnotherDerivativeScript23: these suffer from most of the problems JavaScript does and typically use the same [terrible tooling](https://www.npmjs.com/). it's more of an ecosystem problem than a language design problem (TypeScript has a much better design than classic JS), and adding another unifying JavaScript clone language is not going to make things any better

### w.r.t. Python

[Python](https://www.python.org/) is a dynamic programming language used by new programmers and experienced data scientists alike. a lot of community packages ([NumPy](https://numpy.org/), [TensorFlow](https://www.tensorflow.org/), and so on) make common tasks and quick iterations easier for programmers

Kata and Python both share a lot of design goals (easy to learn, high level, cross platform), but we think Python has some design flaws:

  * syntactical oddities and inconsistent style choices
    * builtin constants are `TitleCase` (`True`, `False`, ...), which trips up many beginners, and is more difficult to type than lower-case versions
    * relevant whitespace means that auto-formatting Python code is impossible (since indentation == block depth, changing the format would change the program). it also can create (silent) bugs when pasting code from a source online
  * lack of the ability to distribute to multiple platforms/machines
    * in particular, Python lacks a way to run in a web browser, or distribute code without using third party solutions
    * Kata has distribution of code as a first-class use case, whereas Python has no builtin solution to do this besides assuming everyone else already has Python installed

### w.r.t. JavaScript

[JavaScript](https://en.wikipedia.org/wiki/JavaScript) is a programming language written and designed about 10 days. it is currently the go-to way to interact with web-browsers and HTML documents.

one thing JavaScript and Kata share in common is the goal of being able to run on any browser, under any conditions. 

JavaScript was not created with any kind of ecosystem in mind, so everything is basically ad-hoc. there's no single way to write JavaScript apps -- the workflow depends on which framework and setup you're using (not to mention variants, like TypeScript, CoffeeScript, ...).

  * type coercion and loose type system make little intuitive sense to most people (prompting the creation of `===` (the triple equals))
  * the lack of composable components, and difficult prototypal type system make it a pain to implement even simple structures
  * the lack of a standard library causes an abundance of low-quality duplicate code (for example, the [leftpad fiasco](https://qz.com/646467/how-one-programmer-broke-the-internet-by-deleting-a-tiny-piece-of-code/))

