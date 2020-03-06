---
title:  1.2 Printing Parts & Pre Assembly
linktitle: 1.2 Printing Parts & Pre Assembly
description: Reduplicator i3 MK3x 3d Printer. Printing and pre assembly  by Mark riganti
author: Mark Riganti
toc: true
type: docs
date: "2019-05-05T00:00:00+01:00"
draft: false
menu:
  MK3x:
    parent: 1. Pre-Assembly
    weight: 1

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 3
---


I recommend ABS or an ABS composite if you have an enclosure or if your printer can produce prints with minimal warping. ABS was chosen as this is what the Prusa MK2s was manufactured with. As of the MK3, Prusa is using PETG which is also fantastic choice. Otherwise PLA may work except for the extruder carriage parts.

If using ABS please allow for a few percent of shrinkage. This is especially important for the feet parts, which need to be exactly level with the underside crossbeam.

Recommended 40-60% infill and 3-4 outer shells for maximum strength.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/2%20Bottom%20Frame/Parts.jpg?raw=true)

These parts make use of brass heat inserts in order to make the strongest prints in the space available. They are installed with a soldering iron. Slowly push the insert into the hole while being careful to keep it as square as possible. Use an Xacto blade to clear the surrounding area of any excess plastic.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/2%20Bottom%20Frame/HeatSert.JPG?raw=true)

These inserts are used on the following parts.
- 2x X Carriage Front Extruder Plate
- 6x X Carriage Rear Bearing Plate
- 2x Part Fan Bracket
- 2x X Gantry Cable Box Bottom
- 4x X Gantry Idler 9MM
- 2x X Gantry Motor Mount
- 2x Y Axis Belt Idler
- 2x Z Rod Securer X2

You will need multiple copies of the following parts:
- Base Leg H26.8mm X4
- Cable Guide Drop In X2-4
- Cable Guide Slide In X2-4
- Tower Corner Bracket Large 80x80x5 V2 (Better Z Clearance) X2 or Tower Corner Bracket Large 80x80x5 V1 X2
- Y Axis Rod Holder Left X2
- Z Rod Securer X2
- Y Carriage Bearing Block X3 (Not required on V2.1 as it already uses lighter plastic bearing blocks)

Most parts can be printed without issue. Supports should not be required in most cases. However some parts are a little trickier and may benefit from a brim to ensure they print flat. This includes:
- X Carriage Front Extruder Plate
- X Carriage Rear Bearing Plate
- Y Axis Rod Holder Left X2
- Y Axis Rod Holder Right
- Y Axis Rod Holder Right & Endstop



### Pre Assembly Decisions
A few decisions will need to be made before assembly.
- The tower top corner bracket is available in 2 forms. **Tower Corner Bracket Large 80x80x5 V1 X2** parts are the ones in the photos, and **Tower Corner Bracket Large 80x80x5 V2 (Better Z Clearance) X2** parts provide better z clearance.

- If you use the stock idler pulleys you will need to use **X Gantry Idler 11mm (Stock idler)**. If using a replacement 9mm idler, the  **X Gantry Idler 9MM** part can be used which should be stronger.

- if you have no access to Misumi parts it is possible to either:
    - Replace the metal brackets with ones from other sources and don't bother with the plastic brackets on top.
    - Use printed brackets, from the **Non Metal Tabbed Brackets** folder which will not be as strong.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/1%20Glamor%20Shots/Non%20Metal%20Brackets.PNG?raw=true)

- Spool Holder and filament guides. Even with the increased rigidity I recommend a control box spool holder. The **Alternative & Optional Parts** folder contains a control box filament guide as well as a top mounted spool roller with PTFE guides and cleaners. This folder also contains alternative stls for cheap Bunnings brackets https://www.bunnings.com.au/zenith-75mm-zinc-plated-corner-brace-bracket-4-pack_p2760923. Also alternative cable routing parts.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/1%20Glamor%20Shots/Alternate%20And%20Extra%20parts.PNG?raw=true)

- Finally the printer can be assembled in two different ways. It can be assembled as outlined here with the vertical rods on the backside of the tower. The large brackets become the front face of the printer. Alternatively is can be assembled similar to the Prusa MK2s where the motors and rods face forward. The benefits of this include a slightly increased Z-height of ~210mm. However i don't have official cable routing for this version but a number of cable chain brackets are available in the **Alternative & Optional Parts** folder. Instructions are similar but you will need to recheck the placement of your z axis crossbeam and the extruder faces the opposite direction.

   - Original Configuration. CAD files available [here](https://www.tinkercad.com/things/azPlfmHU5MQ)

![](https://github.com/OmNomNomagon/ReDuplicator-MK3x/blob/master/Pics/1%20Glamor%20Shots/OrigConfig.JPG)

   - Reversed Configuration. CAD files available [here](https://www.tinkercad.com/things/3dhHpAMNEjQ)

![](https://github.com/OmNomNomagon/ReDuplicator-MK3x/blob/master/Pics/1%20Glamor%20Shots/ReversedConfig.JPG)