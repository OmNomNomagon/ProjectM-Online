---
title: Authors
# The author profile (admin/_index.md) feeds the author card at the foot of every
# project page, so it has to stay in the build. It is not useful as a page of its
# own (it was thin content in search results), so neither /authors/ nor
# /authors/admin/ is published or listed in the sitemap.
build:
  render: never
sitemap:
  disable: true
cascade:
  - build:
      render: never
    sitemap:
      disable: true
---
