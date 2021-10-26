---
layout: post
title: "K#0000: Architecture"
author: Cade Brown
email: me@cade.site
categories: [kata]
tags: [kata, meta]
series: kata
thumb: /files/kata-logo.webp
---

Kata ([kata.tools](https://kata.tools), WIP) is a software ecosystem for building desktop, web, and High Performance Computing (HPC) software using platform-agnostic tooling. so far, an alpha-stage prototype was created in 2021-01, located at [term.kscript.org](https://term.kscript.org)

<!--more-->

Kata includes a few major components to do this job:

  * KataScript (`ks` CLI, `*.ks` files): a high level scripting language, with a rich type system and expressive syntax
  * KataCompiled (`kc` CLI, `*.kc` files): a systems level programming language, for using native types, functions, and modules seamlessly, while also allowing support for dynamic types
  * KataNumeriX (`.knx` files): a compute-only (i.e. no IO) language meant for HPC/ML/AI, which can be JIT/statically compiled and ran using CUDA, HIP, etc... 
    * understands native types, tensors, broadcasting, task scheduling, and host/device communication, but not dynamic types!
  * KataShell (`kash` CLI, `*.kash` files): a shell language meant for task automation, authoring utils/tools, and launching processes/debugging
  * KataPackageManager (`kpm` CLI, `.kpm` files): a file/directory based package manager, builder, and bundler

internally, there are a few other major components (these are also useful for other language designers):

  * KataAST (`kast` CLI, `*.kast` files): a high-level tree-based intermediate language intended as a compilation target for all medium- and high-level languages
    * encodes metadata/debugging information, such as type information, source locations, and other information
    * can be transpiled to KataIR, or used by a third party tool such as an IDE/language server
  * KataIR (`kir` CLI, `*.kir` files): a low-level block-based intermediate representation (IR), which can be optimized and compiled to a backend
    * still encodes metadata/debugging information, but only what is required for error diagnostics
    * should be easily translated to other IRs such as LLVM IR, or WebAssembly

obviously, this is going to take a while and be an iterative process! that's why i'm making this post, to give an estimated roadmap and high level details about the project


## Another Language(s)? Why?

fair point, there are already [a lot of programming languages](https://en.wikipedia.org/wiki/List_of_programming_languages). after all, what point is there to another when there are already so many that do so many different things?

instead of going through every programming language/ecosystem and explaining why they were not satisfying my use cases (you can check [/philosophy](/philosophy)), here are some of the reasons that i think no existing 


### ...okay, but people are using those languages to great success!

that's great for them, and anyone who has success with a language/ecosystem is free to stick with it, just as they are free to stick with any language up until this point

my main goal with the Kata project is to make one ecosystem for any application someone could imagine. and, inevitably, when a new kind of application is needed, Kata gives developers the tools to define DSLs (Domain-Specific-Languages) with built-in lexer and parser generators with full diagnostics that work seamlessly with the existing Kata stack (i.e. they can compile down to `kir`, and easily be included in other Kata-based projects)

## Roadmap

here's my target dates for a few major components:

2021-12-31

  : have a working `kc`, with most of the std/stl implemented within it (i.e. list, tree, graph, ...)

  : it should be bootstrapped via  minimal `ckc` bootstrapping compiler written in C/C++... or maybe even Python, why not?

2022-02-01

  : have a working `ks`, re-using the std/stl from `kc`. i'd like to have the compiler/interpreter written in `.kc`

  : by this time, most of the standard modules should also be implemented or in progress (`os`, `io`, `math`, `time`, `sci`, `ffi`, `getarg`, `kpm`, `langs`, `formats`)

2022-04-20

  : have a working UI demo in the browser, with most of std/stl supported. goal is to be able to do it with 0 HTML/JS/CSS needed to write a web app

2022-09-01

  : have a working demo of doing tensor computations on the GPU, using the `.knx` language
