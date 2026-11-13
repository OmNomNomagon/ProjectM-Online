+++
# Slider widget.
widget = "slider"  # See https://sourcethemes.com/academic/docs/page-builder/
headless = true  # This file represents a page section.
active = true  # Activate this widget? true/false
weight = 10  # Order that this section will appear.

# Slide interval.
# Use `false` to disable animation or enter a time in ms, e.g. `5000` (5s).
interval = 10000

# Slide height (optional).
# E.g. `100px` for 500 pixels or `calc(100vh - 70px)` for full screen.
height = "calc(88vh)"

# The hero is the largest image on the site, so it gets the extra 2560 width.
image_widths = [1280, 1920, 2560]

# Static caption. Rendered ONCE, above the slides, and does not move with them.
# This is the page's only <h1>, so it carries the search weight.
hero_title = "Mark Riganti’s Projects"
hero_lead_items = ["Woodworking", "3D design", "Electronics", "Audio", "Code builds from the Gong"]
hero_align = "center"
# Tagline separator: "dot" (CSS circles, brackets the line) or "slash" (literal //).
lead_sep = "chev"
cta_label = "Explore"
cta_aria_label = "Explore projects"
cta_url = "#projects"

# Slides. Photos only now -- caption and button live above, not per slide.
# `overlay_img` is resolved from `assets/img/`, so Hugo can resize and re-encode it.
# Duplicate an `[[item]]` block to add another photo.

[[item]]
  overlay_color = "#333"
  overlay_img = "slider/PlantDog.jpg"
  alt = "A dog lying on a timber floor among potted plants"
  overlay_filter = 0.6

[[item]]
  overlay_color = "#666"
  overlay_img = "slider/mustangB.jpg"
  alt = "Two P-51 Mustang fighter planes flying above the clouds"
  overlay_filter = 0.6

[[item]]
  overlay_color = "#555"
  overlay_img = "slider/blur-small.jpg"
  alt = "Rain-speckled windscreen with blurred traffic lights at night"
  overlay_filter = 0.6

[[item]]
  overlay_color = "#333"
  overlay_img = "slider/shuffle-small.jpg"
  alt = "A puck on a sanded shuffleboard table in a dimly lit bar"
  overlay_filter = 0.6

[[item]]
  overlay_color = "#333"
  overlay_img = "slider/shuttle-small.jpg"
  alt = "A space shuttle orbiter on display in a museum hangar"
  overlay_filter = 0.6
+++