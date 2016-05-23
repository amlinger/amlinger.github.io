---
layout: post
title:  "Jekyll, and my First Post"
date:   2016-05-23 18:36:14 +0200
categories: jekyll
---
This is my first post in this blog, and I thought that it would be suiting to write a bit about Jekyll, the engine which this blog runs upon, as well as some other design decisions regarding this blog. Jekyll was chosen to fulfill two requirements of mine when it came to using a blog engine;
1. Somewhat transparent, meaning that the source code could be found and read.
2. Not use a database, since version maintaining your posts and seeing what has been written is already done by VCS:s such as Git, that I intended to use anyway.

Jekyll is a static blog engine, that compiles your blog posts written in Markdown to static HTML, which can be served conveniently on GitHub pages.

To be able to use a custom domain, instead of [amlinger.github.io](https://amlinger.github.io) as is the default on GitHub pages, adding a [CNAME](CNAME) file does the trick. The only problem is that GitHub has no way of supporting SSL certificates, leaving you without HTTPS. This might not do too much for a static blog page which source code still is open source on GitHub, but it is bad for SEO. I solved this by signing up for a CloudFare account, where they are kind enough to provide free SSL certificates, and thus solving the HTTPS problem.

This will have to do for a first post of a blog thats still under heavy development. Stay tuned for more updates!

[CNAME]: https://github.com/amlinger/amlinger.github.io/blob/master/CNAME
