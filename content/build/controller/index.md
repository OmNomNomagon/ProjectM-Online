---
title: Wanhao 24v Gen-L TMC2130 upgrade
summary: Wahnao i3 controller upgrade		 
tags:
- 3d
- electro
date: "2020-02-19T00:28:00Z"
type: "widget_page" 


---




An Adaptor to convert the electronics of a wanhao i3 to the following:
 - MKS Gen-L
 - Raspi 2/3/b
 - Mosfet with 8mm x 63mm hole spacing, such as [this one.](https://www.aliexpress.com/item/New-3D-Printer-Heated-Bed-Power-Module-High-Current-210A-MOSFET-Upgrade-RAMPS-1-4-12V/32811898708.html?spm=a2g0s.9042311.0.0.um477z)

The Adaptor fits on top of the existing mounting holes and is secured with M3 screws and washers. The  boards are mounted with M3 screws of a length of 3-6mm.

Place a piece of carboard or foam under the control board to prevent shorts.
Pics and a marlin 1.1.8 config for a working MKS Gen-L and TMC2130 are also included. Due to the cramped spacing in the case, the usual USB Type A cable will not fit without being modified. The rubberised plastic shield needs to be removed to allow the cable to bent enough to fit.

This setup works perfectly with Octopi, and the TMC drivers run cool and quiet with sensorless homing.  [This guide](http://www.3dcampy.com/2017/12/20/tutorial-instalacion-y-configuracion-driver-trinamic-tmc2130-en-ramps-y-mks-gen-1-4/) contains a great TMC2130 wiring guide. The Gen-L is the same except the AUX-3 Header is rotated 180degrees.

Previously I ran a RAMPS board, but it required a lot of modification in order to run at the 24v required for the Trinamic Drivers. After it died the GEN-L was a great cheap substitute that can natively handle the 24v without modification.

I recommend switching out the rear fan with the included 120mm adaptor to keep everything cool as the TMC drivers can generate a fair amount of heat. This shroud is as thin as physically possible. It is 5-15mm shorter than other designs. It has the power port on both the left and right sides. It works when the control box is stand alone and can be flipped 180 degrees to allow for mounting the control box to the bottom or a lack table. The other electrical port hole can be plugged with [this thing](https://www.thingiverse.com/thing:1710028)

When replacing the mainboard, the original wanhao display will not work without rewiring the ribbon cables. Alternatively the Reprap Discount full graphic smart controller is a drop in replacement. With this configuration the SD card is built into the display and will be blocked when mounted into the case. however this isn't an issue when printing via octopi.



### Download 

Downloadable on [thingiverse](https://www.thingiverse.com/thing:2895849)

