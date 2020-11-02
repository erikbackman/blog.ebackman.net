+++
title = "Blogging with Emacs Org-mode and ox-hugo"
author = ["Erik Bäckman"]
date = 2020-11-01T00:00:00+01:00
tags = ["emacs", "org"]
draft = false
weight = 2001
+++

## Workflow and tools {#workflow-and-tools}

I love Emacs and think it's an amazing piece of software that prefectly captures
the essence of what free software is all about.

One of the most popular packages for emacs is [Org mode](https://orgmode.org) which is described as:

> a mode for keeping notes, maintaining TODO lists, and project planning with a
> fast and effective plain-text markup language. It also is an authoring system
> with unique support for literate programming and reproducible research.

And so naturally when I decided to start a blog I wanted to use Emacs and Org mode.
There are a few [tools](https://orgmode.org/tools.html) available for blogging with Org mode and I ended up going with [Hugo](https://gohugo.io)
and [ox-hugo](https://ox-hugo.scripter.co/).

Hugo already has support for Org it is however very limited support and thats
where ox-hugo comes in.
Ox-hugo is an Org exporter backend that exports Org to Hugo-compatible markdown.

So now one might be thinking, why not just use markdown?
The simple answer is: because of Org mode, which is so much more than just editor support for org as a markup language.

Let me give you a few examples:

-   You can write snippets of source-code in the middle of an org document and have access to the same intellisense and syntax highlighting you normally would then run those snippets directly using [Org-Babel](https://orgmode.org/worg/org-contrib/babel/).

-   Org mode also has support for tables and even formulas, no more fiddling with ascii tables manually.

-   Use [Org Capture](https://orgmode.org/manual/Capture.html) to quickly capture new ideas into a blog post entry and set it's status as `TODO` then later have it be automatically exporterd once it's `DONE`

For a more detailed answer please refer to <https://ox-hugo.scripter.co/doc/why-ox-hugo/>

Finally there are a couple of modes avialable for emacs that allows for a
comfortable and distraction free writing experience for example [writeroom mode](https://github.com/joostkremers/writeroom-mode)
and [mixed-pitch mode](https://gitlab.com/jabranham/mixed-pitch)

{{< figure src="/images/zenmode.png" caption="Figure 1: Writeroom mode and mixed-pitch mode" >}}

One of Emacs greatest strengths is being able to combine many different tools into one integrated computing environment and this includes Org mode.


## AWS CloudFront and Hugo {#aws-cloudfront-and-hugo}

I decided to host the on AWS using S3, one of the gotchas I encountered was that
CloudFront does not support returning default root objects in subdirectories and
so links like `example.com/posts/hello-world` does not work.
The fix I ended up using was to assign a lambda function to incoming requests
so that requests for paths that end in `/` are rewritten into `/index.html`
