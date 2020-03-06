---
title: 5.1. Recommendations & Future Dev
linktitle: 5.1. Recommendations & Future Dev
description: Reduplicator i3 MK3x 3d Printer. Recommendations and future dev  by Mark riganti
author: Mark Riganti
toc: true
type: docs
date: "2019-05-05T00:00:00+01:00"
draft: false
menu:
  MK3x:
    parent: 5. Conclusion
    weight: 14

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 15




---

Along with this printer upgrade I also recommend the following mods to get the best of your printer:
- Ramps 1.4 with TMC2100 drivers. This allow for significantly quieter printing after proper calibration. Alternatively SKR and GEN-L boards make the transition to 24v and TMC drivers easier.
- 24v Power supply mod for much faster heating times and better motor speed/torque.
- Auto Leveling via a BL-touch or similar. No more manual leveling. When combined with bilinear leveling in Marlin it is possible to print on warped beds. I was able to remove my glass bed and print directly to a PEI sheet bound to my heatbed. This saves a very significant 300 grams of moving weight.
- POM TR8x8 leadscrew nuts, seem to have a lot less play than the normal brass nuts.
- Replacement Y carriage plate. The stock one is heavy and warps very easily.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/1%20Glamor%20Shots/Close.jpg?raw=true)

I intend to keep this project up to date with the newest improvements from the Prusa i3 mk3s as they become available.


## Sample Prints

![boatyMcboat](https://raw.githubusercontent.com/OmNomNomagon/ReDuplicator-MK2sx/master/Pics/1%20Glamor%20Shots/boaty2.JPG)

![boatyMcboat](https://raw.githubusercontent.com/OmNomNomagon/ReDuplicator-MK2sx/master/Pics/1%20Glamor%20Shots/samplePrints.JPG)


## Future improvements 

this may include:
- ~~A Front extrusion plate for the Titan aero extruder hotend combo.~~ COMPLETED
- ~~Possibly a MK2s style E3DV6 hotend with MK8 extruder gear.~~ Hemera Mount COMPLETED. Provides a great integrated hotend and extruder for a decent price.
- ~~Trinamic TMC2208 silent stepper drivers with UART or TMC2130 drivers for integration into ramps for auto homing and skipped step detection when available.~~ COMPLETED Via MKS GENL with TMC2130 steppers. Also available via cloned Einsy RAMBO, or SKR 1.3 With Trinamic drivers if you would like 32bit
- Based on this [excellent fan roundup](https://www.reddit.com/r/3Dprinting/comments/7kexdv/a_nearly_comprehensive_study_of_cooling_fans_and/), ~~Add a number of alternate fan designs. This will include a Dii Cooler derivative and direct blower fan design. The fan in this project is based on Thorped's design, It scores similarly to the Cii cooler in this test due to a straighter path from fan to nozzle.~~ IMPROVED MK3 Fan Shroud added. very similar performance to Dii Cooler. New MK3s cooler based on the R4 will be completed soon.
- ~~New X Carriage design based on the [upcoming MK3 x carriage design](https://www.prusaprinters.org/original-prusa-i3-mk3-2-months/) with incorporated belt tensioner~~ COMPLETED
- MK3s Filament Sensor
- ~~Redesign for a MK52 heatbed and usability of the full 250x210mm heatbed. Will require new extrusions and Rods as the original Wanhao X-axis rods are much smaller than the MK3 ~~ COMPLETED