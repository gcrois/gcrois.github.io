---
layout: post
title: "K#0001: KataIR Design"
author: Cade Brown
email: me@cade.site
categories: [kata]
tags: [kata, meta]
series: kata
thumb: /files/kata-logo.webp
---

an [intermediate representation (or IR)](https://en.wikipedia.org/wiki/Intermediate_representation) is a way of representing code in a format that is easy to parse, analyze, and transform. they're used in compilers to simplify the workflow and ease portability. for that reason, we are going to be designing an IR for kata and its languages, called KataIR

<!--more-->

for example, here are a few IRs used in popular compilers:

  * [GCC GIMPLE](https://gcc.gnu.org/onlinedocs/gccint/GIMPLE.html)
  * [LLVM IR](https://llvm.org/docs/LangRef.html)
  * [LLVM MLIR](https://mlir.llvm.org/)


## Goals

  * be easily generated by the major Kata programming languages (`*.kc`, `*.ks`)
  * completely cross platform (e.g. no 32/64 bit leakage/specification required)
    * platform specific types can be used, but should be reducable to a standard type (i.e. `usize` -> `u32` or `u64` during lowering)
  * easily translated to LLVM IR/MLIR for code generation/JIT/AOT
  * easily translated to WASM (WebAssembly) for code generation/JIT in the browser
  * easily parsed by machines and humans
  * support rich type system, including structures, tagged/untagged union
  * support exception handling

## Non-Goals

  * direct support for hardware specific instructions (this will be done in lower level passed with LLVM MLIR/IR)
  * direct support for specifying linking/ABI (it should be the target's native)

## Spec

this is the informal (but quick) explanation of KataIR. for reference, a KataIR file is a `.kir` file, which contains a textual representation of the IR

(eventually, we will also have `.kirb` for a smaller, binary representation. but for now, we'll keep it simple with text-only)

within a given file, there are modules, which are indicated by the `module <name> { ... }` construct. at the top level, there should only be a list of modules (i.e. functions/types/vars/etc cannot be defined without a module)

within each module, there can be any number of:

  * submodules, using the same syntax
  * imports, indicated by `import <name>` (where `<name>` is the absolute name of another module)
  * type definitions, indicated by `type <name> (extends <name>)? (layout { ... })? { ... }`
  * func definitions, indicated by `func <name>() <flags...> { ... }`
    * there are 2 names which are special: `__init()` is ALWAYS called once when the module is loaded, `__main(...)` is called if the module is being executed as a program (or can be called to simulate that) 
  * var definitions, indicated by `var <name>: <type>`

within a function, there can be multiple "blocks" (the first one is the entry to the function, and should be named `entry`). each block is a basic block, which is explained later. but, most function bodies will not look like the code that generated them

blocks contain a list of operations, which actually manipulate variables, do computation, and implement the functionality

## Implementation

the basic plan is to provide a C/C++ library (`libkir`) for parsing, building, analyzing, and basic transformations. it will be lean, and be embeddable within other applications/libraries

so, for example, the `*.kc` frontend will be fairly straightforward, as it doesn't have the "bells and whistles" that the `*.ks` does (i.e. automatic operator overloading, virtual functions by default, destructuring, etc...). but, they will both result in `.kir` files that can be lowered, compiled to native code (or WASM), or JIT compiled on the fly

the source code is available [on GitHub](https://github.com/katatools/Kata), as `kir` is part of the standard Kata suite

### C++? I thought we were replacing it, not using it!

well, as much as i'd like to write this in a kata-based language itself, we must first solve the [boostrapping problem](https://en.wikipedia.org/wiki/Bootstrapping_(compilers)). eventually, the plan is to implement all this in kc or ks themselves. however, as we don't have a kc compiler yet we need to build one in an existing language

since we are going to write the initial version in C++, we will use [flex](https://github.com/westes/flex) and [Bison](https://www.gnu.org/software/bison/)


### IR Implementation

I'll be storing the definition of all types in the `include/kir/kir.hh` file:

```c++
/* kir/kir.hh - main header for the KataIR (kir::) library
 *
 * @author: Cade Brown <me@cade.site>
 */

#pragma once
#ifndef KIR_HH
#define KIR_HH

// C++ std/stl
#include <string>
#include <vector>
#include <map>
#include <unordered_map>

namespace kir {

// an abstract type that represents any component of the IR which is referencable
struct Node {

    // the name of the node as a result/reference
    //   Module: the full name of the module, with '.' between each level (for submodules)
    //   Block: the name of the local block within a function
    //   Op: the name that the operation as stored as (i.e. a variable name, or a temporary name)
    std::string name;

    // default constructor, should work for all nodes
    Node(const std::string& name="void") : name(name) {}

    // overridable method to return a string representation of a node
    virtual std::string str() {
        return name;
    }

};

// represents an operation, which is like an abstract version of an assembly instruction
// for example, an operation might correspond to an instruction, or might be "lowered" into a few
//   different instructions
// NOTE: this is the abstract base type, check 'ops' subfolder to find other operations
struct Op : public Node {
 
    // arguments given to the node, which can be constants, variables, or locations
    std::vector<Node*> args;
   
};

// represents a basic block of code, which is a sequence of non-branching instructions followed
//   by a single branching instruction
// NOTE: a block may be incomplete at any given time, while being generated. but, optimization
//         passes can assume a block is always correct
struct Block : public Node {

    // the body of the block
    std::vector<Node*> body;
   
};

// represents a reference to a any type of var, func, type, or module
// for example, 'usize'/'ssize' are integer types that start out at a RefNode, but
//   are replaced with a specific type during lowering
// NOTE: this should be lowered during a pass
struct RefNode : public Node {

};

// represents a type definition
struct Type : public Node {

    // the base type, or NULL if there is no base type
    Node* base;
    
    // list of members/layout as (type, name)
    // NOTE: if 'base != NULL', these are in addition to 'base'
    std::vector< std::pair<Node*, std::string> > layout;

    // list of funcs as (func, name)
    std::vector< std::pair<Node*, std::string> > funcs;

    Type(
        const std::vector< std::pair<Node*, std::string> >& layout,
        const std::vector< std::pair<Node*, std::string> >& funcs
    ) : layout(layout), funcs(funcs) {}

};

// represents a function (func), which is a callable piece of code
//   that defines inputs and outputs
struct Func : public Node {
    
    // list of function arguments as (type, name)
    std::vector< std::pair<Node*, std::string> > args;

    // the entry point of the func, or NULL if this function is not defined
    Block* entry;

    Func(
        const std::vector< std::pair<Node*, std::string> >& args,
        Block* entry = NULL
    ) : args(args), entry(entry) {}
};

// represents a module, which has a namespace
struct Module : public Node {

    // list of types as (type, name)
    std::vector< std::pair<Node*, std::string> > types;

    // list of funcs as (func, name)
    std::vector< std::pair<Node*, std::string> > funcs;

    // list of vars as (type, name)
    std::vector< std::pair<Node*, std::string> > vars;

    Module(
        const std::vector< std::pair<Node*, std::string> >& types= {},
        const std::vector< std::pair<Node*, std::string> >& funcs= {},
        const std::vector< std::pair<Node*, std::string> >& vars=  {}
    ) : types(types), funcs(funcs), vars(vars) {}

};

} // kir::

#endif // KIR_HH

```



our IR also allows for a quick and dirty minimization using UNIX utilities:

```shell
$ cat examples/kir/helloworld.kir | tr '\n' ' ' | sed -e 's/[ \t]\+/ /g'
 module $helloworld { func $main() { block %entry { ret $x; } } }
```
