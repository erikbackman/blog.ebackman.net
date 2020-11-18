+++
title = "Blogging with Emacs Org-mode and ox-hugo"
author = ["Erik Bäckman"]
date = 2020-11-18T00:00:00+01:00
tags = ["emacs", "org", "hugo"]
draft = false
+++

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


## The setup {#the-setup}

**Project Structure**

```bash
tree -L 2 --dirsfirst
```

```bash
.
├── content
│   ├── pages
│   └── posts
├── static
│   └── images
├── themes
│   └── m10c
├── blog.org
├── config.toml
```

This is pretty much the structure you end up with after running `hugo new`.

In the root of the project I have a file called `blog.org` which contains all my
posts as well as the pages on my blog such as the about page.

**blog.org**

```org
#+HUGO_BASE_DIR: .
#+HUGO_SECTION: posts

* Pages
:PROPERTIES:
:EXPORT_HUGO_CUSTOM_FRONT_MATTER: :noauthor true :nocomment true :nodate true :nopaging true :noread true
:EXPORT_HUGO_MENU: :menu main
:EXPORT_HUGO_SECTION: pages
:EXPORT_HUGO_WEIGHT: auto
:END:
** DONE About
:PROPERTIES:
:EXPORT_FILE_NAME: about
:END:
I'm a self-taught programmer currently working at [[https://learningwell.se][LearningWell]] in Sweden.
...
* Posts
** DONE Hello World!
:PROPERTIES:
:EXPORT_FILE_NAME: hello-world
:EXPORT_DATE: <2020-10-29 Thu>
:END:
This is the first of hopefully many posts to come.
...
```

In the above snippet we can see that the default `HUGO_SECTION` is set to
`posts` resulting in entries being exported to `content/posts/<filename.md>`,
the `Pages` heading overrides this setting, making any of it's sub-headings
instead be exported to `content/pages/<filename.md>`, in addition these entries
will show up in the main menu.


## Workflow {#workflow}

My usual workflow looks like this:

1.  Think of an idea for a new post, use [Org Capture](https://orgmode.org/manual/Capture.html) to quickly capture this idea into a new post and save it as a new `TODO` entry under the `Posts` heading in `blog.org`
2.  After finishing the post I change it's state to `DONE` which will trigger the `org-hugo-export-to-md` any time I save the post.

Here's the code that adds a Hugo template to Org Capture:

```emacs-lisp
(with-eval-after-load 'org-capture
  (defun new-hugo-post (title)
    (s-join "\n" `(,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " (org-hugo-slug title))
                   ":END:"
                   "%?\n")))

  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post. "
    (let* ((title (read-from-minibuffer "Post Title: ")))
      (new-hugo-post title)))

  (add-to-list 'org-capture-templates
               '("h"
                 "Hugo post"
                 entry
                 (file+olp "blog.org" "Posts")
                 (function org-hugo-new-subtree-post-capture-template))))
```


## Hosting {#hosting}

I decided to host the on AWS using S3, one of the gotchas I encountered was that
CloudFront does not support returning default root objects in subdirectories and
so links like `example.com/posts/hello-world` does not work. The fix I ended up
using was to assign a lambda function to incoming requests so that requests for
paths that end in `/` are rewritten into `/index.html`


## Useful packages {#useful-packages}

I want to mention a few packages that I use to get a more comfortable and
distraction free writing experience. The main one is [writeroom mode](https://github.com/joostkremers/writeroom-mode) which adds a
mode for distraction-free writing, the other one is [mixed-pitch mode](https://gitlab.com/jabranham/mixed-pitch) which makes
it possible to mix fixed-pitched and variable-pitch fonts in the same buffer.

This is what it ends up looking like:
![](/images/writeroom.png)
