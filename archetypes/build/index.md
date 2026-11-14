---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
# Homepage grid card. Lower card_weight = earlier in the grid; the existing
# projects run 200 (first) to 2200 in steps of 50, so 100 puts this one first.
card: true
card_weight: 100
# Optional shorter wording for the card than the page itself:
# card_title: ""
# card_summary: ""
summary: ""
# One or two sentences for search results (aim for 120-160 characters).
description: ""
author: Mark Riganti
# One or more of: wood, 3d, audio, electro, dev. The first is the card's type.
tags:
- wood
date: {{ .Date }}
type: "widget_page"
---

<!--
  How this folder works (delete this comment when done):
  - featured.jpg   the grid card and share photo (landscape works best)
  - G1.jpg, G2.jpg the slider at the top of the page, in name order
  - any other photo, placed in the text with  ![What it shows](photo.jpg)
  Photos are resized and converted automatically; put the originals here.
  Write a short description inside the [ ] for each photo: it becomes its alt
  text for search engines and screen readers.
-->

What it is, and why you built it.

### Materials

- 

### Build

![First step](step1.jpg)

### Download

