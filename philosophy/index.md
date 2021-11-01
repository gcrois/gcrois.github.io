---
layout: page
title: Philosophy of Kata
permalink: /philosophy
use_jquery: true
use_prism: true
---


Kata is designed with a unifying philosophy of mathematics and computation in mind, based on Mathematical Platonism and [Digital Philosophy](https://en.wikipedia.org/wiki/Digital_philosophy). specifically (emphasis ours):

> Mathematical Platonism is the metaphysical view that there are **abstract mathematical objects whose existence is independent** of us and our language, thought, and practices. 
> 
> **Just as electrons and planets exist independently of us, so do numbers and sets**. And just as statements about electrons and planets are made true or false by the objects with which they are concerned and these objects’ perfectly objective properties, so are statements about numbers and sets. 
>
> **Mathematical truths are therefore discovered, not invented.**
>
> -- Stanford, [*Platonism in the Philosophy of Mathematics*](https://plato.stanford.edu/entries/platonism-mathematics/)

![Theory of Forms diagram](/files/TOF-0.webp){: .img-left }

on a conceptual level, this allows for a more expressive and dynamic language that more closely mirrors programmers' intentions, rather than the particular steps a given machine may take to achieve such intentions. 

as a result, written programs can be more easily read by others, including those who are not familiar with computers at a low level. 

on a practical level, this allows for efficient implementation of concepts on different hardware situations (for example, on a mobile device, desktop application, web browser, embedded system, or even a GPU/external processor), which is a useful and neccessary feature for the future of ubiquitous computing:

  * Kata is designed to prevent vendor lock-ins, which is a common problem in the industry
  * Kata is designed to be open source by design, and encourage FOSS applications/libraries that can be shared across operating systems, platforms, and hardware


<div style="clear: both;"></div>

![Kata Name Origin](/files/kataname.webp){: .img-right }

## 'Kata' Name Origin

'Kata' gets its name from the Greek [κατά](https://en.wiktionary.org/wiki/%CE%BA%CE%B1%CF%84%CE%AC#Ancient_Greek), which has a few related meanings (see the image on the right).

most primarily, it means 'according to, in conformity with' (referencing concepts and [abstract data types](https://en.wikipedia.org/wiki/Abstract_data_type)), and 'downwards' (referencing that programs are written in a [top-down fashion](https://en.wikipedia.org/wiki/Top-down_and_bottom-up_design))


<!--

## Differences

### "Why Not Language {X, Y, Z}?"

of course, there's a multitude languages that Kata/etc are *not* based on. it would be an impossible task to describe its relation to each one. instead, here are a few of the most popular languages, and why they didn't satisfy the use cases of Kata:

  * C: great for portability and performance, but severely lacking in composition, type systems, and the syntax has too many quirks
  * C#: a very well designed language, but within the larger .NET/CLR ecosystem (which is theoretically cross platform, but mysteriously very few apps written in it ever end up running outside of Windows...), and leans too much into the C-style syntax and pure-academic object-oriented programming paradigms
    * i know things like F# and other .NET languages are easy-interop with each other, but they weren't designed to truly be platform agnostic and web-oriented, which are now major use cases
  * Python: great for high level problem solving, "driver" code (as opposed to "engine"), but syntax is terrible (relevant whitespace, TitleCase constants, abuse of `:`, weird naming conventions, awkward syntax for `lambda`, the list goes on). also, the standard library is just... not designed well. so many quirks, inconsistencies, and odd formulations (not to mention "hello, world" breaking!)
  * JavaScript: come on now... i'm not going to even mention why JavaScript is not the one...

the above were only languages i consider myself fluent in (5+ years) and still use regularly. The following are languages i haven't used, or stopped using for one reason or another:

  * Rust: [it's difficult to learn](https://vorner.github.io/difficult.html). at least 90% of developers that i've known have tried it complain about the difficulty. it's poorly designed, and difficult to write non-linear programs with the borrow-checker
  * TypeScript/CoffeeScript/AnotherDerivativeScript23: these suffer from most of the problems JavaScript does and typically use the same [terrible tooling](https://www.npmjs.com/). it's more of an ecosystem problem than a language design problem (TypeScript has a much better design than classic JS), and adding another unifying JavaScript clone language is not going to make things any better

### w.r.t. Python

[Python](https://www.python.org/) is a dynamic programming language used by new programmers and experienced data scientists alike. a lot of community packages ([NumPy](https://numpy.org/), [TensorFlow](https://www.tensorflow.org/), and so on) make common tasks and quick iterations easier for programmers

Kata and Python both share a lot of design goals (easy to learn, high level, cross platform), but we think Python has some design flaws:

  * syntactical oddities and inconsistent style choices
    * relevant whitespace means that auto-formatting Python code is impossible (since indentation == block depth, changing the format would change the program). it also can create (silent) bugs when pasting code from a source online
    * builtin constants are `TitleCase` (`True`, `False`, ...), which trips up many beginners, and is more difficult to type than lower-case versions
  * lack of the ability to distribute to multiple platforms/machines
    * in particular, Python lacks a way to run in a web browser, or distribute code without using third party solutions
    * Kata has distribution of code as a first-class use case, whereas Python has no builtin solution to do this besides assuming everyone else already has Python installed

### w.r.t. JavaScript

[JavaScript](https://en.wikipedia.org/wiki/JavaScript) is a programming language written and designed about 10 days. it is currently the go-to way to interact with web-browsers and HTML documents. truth is stranger than fiction, and so on...

one thing JavaScript and Kata share in common is the goal of being able to run on any browser, under any conditions. 

JavaScript was not created with any kind of ecosystem in mind, so everything is basically ad-hoc. there's no single way to write JavaScript apps -- the workflow depends on which framework and setup you're using (not to mention variants, like TypeScript, CoffeeScript, ...).

  * type coercion and loose type system make little intuitive sense to most people (prompting the creation of `===` (the triple equals))
  * the lack of composable components, and difficult prototypal type system make it a pain to implement even simple structures
  * the lack of a standard library causes an abundance of low-quality duplicate code (for example, the [leftpad fiasco](https://qz.com/646467/how-one-programmer-broke-the-internet-by-deleting-a-tiny-piece-of-code/))
-->
