+++
title = "Blogging with Emacs Org-mode and ox-hugo"
author = ["Erik Bäckman"]
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
The simple answer is: because of Org mode, which is far more feature rich and
powerful than any markdown tool currently available - at least that I know off.

For a more detailed answer please refer to <https://ox-hugo.scripter.co/doc/why-ox-hugo/>

**A few of my favorite  reasons are:**

-   Being able to directly include source code snippets from external files and
    running these snippets using [Org Babel](https://orgmode.org/worg/org-contrib/babel/)

-   Capturing new post ideas as Org Todo entries using [Org Capture](https://orgmode.org/manual/Capture.html) and having them
    be exported once they are marked as being `DONE`.

-   Comfortable and distraction free writing experience using [writeroom mode](https://github.com/joostkremers/writeroom-mode) together with [mixed-pitch mode](https://gitlab.com/jabranham/mixed-pitch).

    {{< figure src="/images/zenmode.png" caption="Figure 1: Writeroom mode and mixed-pitch mode" >}}


## AWS CloudFront and Hugo {#aws-cloudfront-and-hugo}

I decided to host the on AWS using S3, one of the gotchas I encountered was that
CloudFront does not support returning default root objects in subdirectories and
so links like `example.com/posts/hello-world` does not work.
The fix I ended up using was to assign a lambda function to incoming requests
so that requests for paths that end in `/` are rewritten into `/index.html`
