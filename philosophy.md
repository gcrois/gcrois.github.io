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

### w.r.t. Python

[Python](https://www.python.org/) is a dynamic programming language used by new programmers and experienced data scientists alike. a lot of community packages ([NumPy](https://numpy.org/), [TensorFlow](https://www.tensorflow.org/), and so on) make common tasks and quick iterations easier for programmers

Kata and Python both share a lot of design goals (easy to learn, high level, cross platform), but we think Python has some design flaws:

  * syntactical oddities and inconsistent style choices
    * builtin constants are `TitleCase` (`True`, `False`, ...), which trips up many beginners, and is more difficult to type than lower-case versions
    * relevant whitespace means that auto-formatting Python code is impossible (since indentation == block depth, changing the format would change the program). it also can create (silent) bugs when pasting code from a source online
  * lack of the ability to distribute to multiple platforms/machines
    * in particular, Python lacks a way to run in a web browser, or distribute code without using third party solutions

### w.r.t. JavaScript

[JavaScript](https://en.wikipedia.org/wiki/JavaScript) is a programming language written and designed about 10 days. it is currently the go-to way to interact with web-browsers and HTML documents.

one thing JavaScript and Kata share in common is the goal of being able to run on any browser, under any conditions. 

JavaScript was not created with any kind of ecosystem in mind, so everything is basically ad-hoc. there's no single way to write JavaScript apps -- the workflow depends on which framework and setup you're using (not to mention variants, like TypeScript, CoffeeScript, ...).

  * type coercion and loose type system make little intuitive sense to most people (prompting the creation of `===` (the triple equals))
  * the lack of composable components, and difficult prototypal type system make it a pain to implement even simple structures
  * the lack of a standard library causes an abundance of low-quality duplicate code (for example, the [leftpad fiasco](https://qz.com/646467/how-one-programmer-broke-the-internet-by-deleting-a-tiny-piece-of-code/))


