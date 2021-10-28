# katatools.github.io ([https://kata.tools](https://kata.tools))

this is the source code for for [katatools.github.io](https://katatools.github.io) ([kata.tools](https://kata.tools))

## setup

first, you'll need to install the [Jekyll stack](https://jekyllrb.com/docs/installation/). follow that link and find your platform


### software

this blog has a lot of builtin integrations with common tools. here's a quick list:

  * [kramdown](https://kramdown.gettalong.org/syntax.html): for parsing `.md` (markdown) files
  * [Prism.js](https://prismjs.com/): for code highlighting
    * [example: shell/commandline highlighting](https://github.com/cadebrown/cadebrown.github.io/blob/main/_posts/2021-09-28-diy-regex-engine.md)
    * [example: tree/directory view](https://prismjs.com/plugins/treeview/)
    * [example: pretty 'diff' output](https://prismjs.com/plugins/diff-highlight/)
    * if you're not satisfied with my Prism config, [use their wizard](https://prismjs.com/download.html)
    * to add more languages, add them in the [js/components](./js/components) folder (TODO: example of this)
  * [KaTeX](https://www.katex.org/): for math formatting (LaTeX-like, and much faster than MathJax)
    * to use it in a post, use `$ x^2 + x + 5$` (for inline), or `$$ x^2 + x + 5 $$` (for block mode)
  * [git.io](https://git.io/): for URL shortening (useful for gists)
  * [GitHub Buttons](https://buttons.github.io/): includes the style in the head element, so just paste the element!
  * Google Analytics: for analyzing your web traffic

## running

to serve locally:

```shell
$ bundle exec jekyll serve
...
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
```
and navigate to `localhost:4000` in your browser

give `--drafts` to also include draft posts, include `--host 0.0.0.0` to serve to your local network


### tips

here are some tips

  * use `.webp` files for images ([use `cwebp` if possible](https://developers.google.com/speed/webp/docs/cwebp))
  * to check your images, use [imagemagick](https://imagemagick.org/script/identify.php)
    * for example, `for f in files/*; do identify -format '%f %wx%y\n' $f; done` and look for any abnormally large images
  * specify only the software you need for a file with the `use_*` settings (see `_config.yml` for specifics)
    * by default, posts use KaTeX and Prism.js, while most pages *don't even load them in*

## misc links

  * https://docs.python.org/3/faq/design.html#why-does-python-use-methods-for-some-functionality-e-g-list-index-but-functions-for-other-e-g-len-list
