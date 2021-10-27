---
layout: post
title: "K#0001: Form-Based Programming (a.k.a Platonic Typing)"
author: Cade Brown
email: me@cade.site
categories: [kata]
tags: [kata, types]
series: types
thumb: /files/src/K0001/types0.dot.webp
---

buckle up! we're about to deep dive into the world of types, values, templates, and math. particularly, how they are used in the Kata programming languages, and how they are used to do "Form Based Programming"

<!--more-->

![type graph 0](/files/src/K0001/types0.dot.webp)

the above figure is a graph of some types and templates in the Kata type system. each node represents a type (if round) or a template (if octogonal). each node represents a base-extends type relationship (if solid), a type-template relationship (if dotted `. . .`), and/or an automatically decay-able/cast-able type (if dashed `- - -`).


for example:

  * `u32`: a 32-bit unsigned integer
  * `f32`: a 32-bit floating point number (`float` in C)
  * `string`: an immutable shared string of Unicode characters
  * `array[T]`: a template that generates a mutable array container type, with elements of type `T`
  * `maybe[T]`: a template that generates a container type that can either contain a value of type `T` or be empty
  * `union[*T]`: a template that generates a container type that can be any of `*T` (which is 1-or-more types)


```kata

form list[T] {

  decl len: int;

  func get(i: int)->T;
  func set(i: int, v: T)->void;
  func push(v: T)->void;

  # declare other forms we participate in
  as iter[T];
}

type array[T] {
  is list[T];

  len: usize;
  cap: usize;
  data: ptr[T];

  func get(i: usize)->T {
    if i >= len {
      throw errors.
      throw IndexOutOfBoundsError(i);
      ret;
    }
    ret data[i];
  }

  func set(i: usize, v: T)->void {
    data[i] = v;
  }


}





# dictionary template type
template dict[K: type, V: type] {

  # hash table buckets
  buks: array[usize];

  # hash table entries (includes deleted entries)
  ents: array[(K, V, usize)];

  func get(k: K, h: usize)->V? const {
    # get initial bucket pos
    const b0: usize = h % buks.len();
    
    # now, iterate over them
    let b: usize = b0;
    do {
      # get entry index from the bucket
      let ei: usize = buks[b];
      if ei == usize.max() {
        # hit empty, so we're done
        ret;
      } elif ei < ents.len() {
        # valid entry, so check
        let e: (K, V, usize) = ents[ei];
        if e.2 == h && e.0 == k {
          # hash and key match, so return val
          ret e.1;
        }
      }

      # next bucket
      b = (b + 1) % buks.len();
    } while b != b0;

    # found nothing
    ret;
  }

  func set(k: K, v: V, h: usize)->void {
    # get initial bucket pos
    const b0: usize = h % buks.len();
    
    # now, iterate over them
    let b: usize = b0;
    do {
      # get entry index from the bucket
      let ei: usize = buks[b];
      if ei == usize.max() {
        # hit empty, so we can insert
        ei = ents.size();
        ents.push((k, v, h));
        buks[b] = ei;
        ret;
      } elif ei < ents.len() {
        # valid entry, so check
        let e: (K, V, usize) = ents[ei];
        if e.2 == h && e.0 == k {
          # hash and key match, replace val
          ents[ei].1 = v;
          ret;
        }
      }

      # next bucket
      b = (b + 1) % buks.len();
    } while b != b0;

    # found nothing
    throw Error("TODO... resize hash table");
    ret;
  }

  # this section shows how we implement various forms
  is map[K, V] {
    func get(k: K)->V? const {
      ret get(k, k.hash());
    }

    func set(k: K, v:V)->void {
      ret set(k, v, k.hash());
    }

    # we can nest forms as well (refer to the graph figure)
    # this controls how the 'map' form is turned into a 'list' form when casted
    as list[(K, V)] {
      func make()->list[(K, V)] {
        ret [(k, v) for k, v, h in ents];
      }
    }
  }
}

```

