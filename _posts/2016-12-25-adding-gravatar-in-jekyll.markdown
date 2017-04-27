---
layout: post
title:  "Adding Gravatar in Jekyll"
date:   2016-12-25 13:28:14 +0200
categories: jekyll
---
I'm a big fan of [Gravatar](https://gravatar.com/). I like the idea of being able to keep track of my profile photos in a central location, instead of having to change them at each service, remembering where I've stored the photos locally, and so on.

Another advantage of the Gravatar service is the possibility to request profile images of different sizes, based on what is needed in the context. This is useful especially when you only need a thumbnail.

To accommodate for this, and to learn a bit more about the way Jekylls plugin system works, I wrote a small tag rendering the URL to a profile image given an email, and a size of the desired image. I went with the following tag interface for including Gravatars:

{% raw %}
`{% to_gravatar email: anton.amlinger@gmail.com, size: 50 %}`
{% endraw %}

The resulting script takes an email and a size in pixels, and returns a URL to the corresponding image. Gravatars API is based on an md5 hexadecimal representation of the email of the user, making the implementation rather straight forward:

{% gist amlinger/21ac760f9ce244ff7d5a75742a47bc18 %}

_The demand for yet another plugin for adding Gravatar to Jekyll (there already are a few) does not seem to be very large to me, which is why this is kept in a Gist and not as an actual Gem._
