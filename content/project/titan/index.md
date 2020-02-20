---
title: Titan Aero Upgrade
summary: For Reduplicator MK3x		 
tags:
- 3d
date: "2020-02-19T00:32:00Z"


# Optional external URL for project (replaces project detail page).
external_link: 

image:
  caption: Titan Aero
  focal_point: Smart
---


### Summary

This Titan Aero mount was designed to be compact as possible in the available space. This is done by keeping the hotend closer to the X axis rods than other mounts, minimizing the Z height and width profile while keeping it as strong and light as possible.

It was designed for the ReDuplicator MK2sx which started life as a Wanhao Duplicator i3.
This uses the same X carriage rear bearing plate as the original MK10 Re-Duplicator carriage. It can be found on the original project  [here.](https://www.thingiverse.com/thing:2686588/#files)

The new shroud is based on the Prusa MK3 one. It results in much better overhang performance. 60 degree overhangs are flawless with some sagging [@70 degrees.](https://raw.githubusercontent.com/OmNomNomagon/ReDuplicator-MK2sx/master/Pics/9%20Titan/overhang.jpg). It is almost comparable to the [Dii Cooler via testing.](https://www.reddit.com/r/3Dprinting/comments/7kexdv/a_nearly_comprehensive_study_of_cooling_fans_and/)

Make sure your Re-duplicator idler part is the new V2 design it includes additional mounting points for the X endstop. The X-axis endstop is mounted on the bottom of the X-axis idler part. The endstop will need to be relocated to the middle or furthest holes depending on the positioning of your heatbed. However if you've already printed the original idler V1, new holes can be drilled in at 5mm intervals with a 1.5mm drill bit. 

The new required printed parts when upgrading from the MK10 extruder are the:
 - Front Bearing Plate
 - Titan Aero MK3 Part Cooling Fan Mount
 - Titan Aero MK3 Part Cooling Fan Shroud
 - BLTouch Mount (optional).

![Oh hai](https://github.com/OmNomNomagon/ReDuplicator-MK3x/blob/master/Pics/1%20Glamor%20Shots/PrintDemo.webp?raw=true)


Probe Offset values for marlin configuration

\#define X_PROBE_OFFSET_FROM_EXTRUDER -16
\#define Y_PROBE_OFFSET_FROM_EXTRUDER -42 


### Assembly

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/9%20Titan/TitanMain.JPG?raw=true)


The new MK3 Based **Titan Aero X Carriage Front Plate MK3 V2** and **X Carriage Rear Bearing Plate MK3 V2** have different spacing than the original parts. This new carriage can be installed and removed from the x-rods without having to disassemble the printer and are much easier to work with. it also uses a different belt securing method that is easier to tension.

![](https://raw.githubusercontent.com/OmNomNomagon/ReDuplicator-MK2sx/master/Pics/4%20Hotend/CarriageNew.jpg)

The new required printed parts are the:
 - Titan Aero X Carriage Front Plate MK3 V2
 - Titan Aero MK3 Part Cooling Fan Mount
 - Titan Aero MK3 Part Cooling Fan Shroud
 - X Carriage Rear Bearing Plate MK3 V2 (Same part as the MK10 extruder)
 - BLTouch Mount (optional).

Installation is very similar to the original MK10 hotend.
Four Heatserts are placed into the front of the Rear Extruder plate. Two heat serts are inserted into the rear.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/4%20Hotend/Carriage1.jpg?raw=true)

Two optional Heatserts are required on in the the prongs on the X Carriage Front Extruder Plate. If you are not using a BLTouch or similar levelling probe you can skip this.

Merge these two parts together using the 2x 16-20mm M3 screws into the centre screw holes. This can be tricky due to the restricted space. Secure them on the back with 2x M3 nylock nuts.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/9%20Titan/TitanPart.JPG?raw=true)

Insert 2 more heat-sert parts into the Titan MK3 Cooling Fan.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/9%20Titan/Fan1.jpg?raw=true)

Screw the Fan bracket to the Fan with a 12mm m3 screw and nylock nut. Attach the 50mm blower fan via an M4x25mm screw and M4 Nylock. A rubber washer in between will help to reduce vibrating fan noise.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/9%20Titan/Fan2.jpg?raw=true)

Use 2 16mm M3 screws through the bottom x carriage screw holes and into this part.

Place your bearings into the carriage. This design allows you to use M3 screws to adjust the tension on the bearing. This is very helpful for Igus bearings. I settled on 2 a copmbination of 2 igus bearing and a misumi LM8LUU to give a smooth easy and quiet movement.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/9%20Titan/FanMount.jpg?raw=true)

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/9%20Titan/TitanFree.JPG?raw=true)

Install the extruder motor and extruder plate as per E3D's throughout instructions. [E3d Titan Aero Instructions](https://wiki.e3d-online.com/Titan_Aero)

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/9%20Titan/TitanWeight.JPG?raw=true)


Once completed this should be significantly lighter than the original. The original MK10 Extruder came to 620 grams.
This new design comes in at 380 grams, around 240 grams lighter.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/9%20Titan/TitanClose.JPG?raw=true)

Assembly can continue as per normal. 

![](https://raw.githubusercontent.com/OmNomNomagon/ReDuplicator-MK2sx/master/Pics/5%20Gantry/XTension.jpg)


Probe Offset values for marlin configuration

\#define X_PROBE_OFFSET_FROM_EXTRUDER -16

\#define Y_PROBE_OFFSET_FROM_EXTRUDER -42 


##3 Changelog


1.0 - Initial Release

1.1 - Due to reports of poor fan position I replaced the Thorped based fan with the Prusa MK3 based Fan and fan mount. Results in much better overhang performance. flawless @60 degree overhang with some sagging @70 degree overhang. The original would show artifacts [@60 degrees.](https://raw.githubusercontent.com/OmNomNomagon/ReDuplicator-MK2sx/master/Pics/9%20Titan/overhang.jpg). Almost comparable to the [Dii Cooler.](https://www.reddit.com/r/3Dprinting/comments/7kexdv/a_nearly_comprehensive_study_of_cooling_fans_and/) Older retired files are still available [via github](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/tree/master/STLs%20Titan%20Aero%20Conversion/Retired%20Versions)

1.2 Prusa MK3 Update. Added a new belt securing method based on the Prusa MK3  which is much easier to install under tension. However this requires new hole spacing. The original carriage parts are not compatible with the new  **X Carriage Rear Bearing Plate MK3 V2** and Titan Aero X Carriage Front Plate MK3 V2. The whole carriage assembly can now be removed and installed from the X-rods without disassembling the printer. 3x 16mm m3 screws secure it to the bearings. 
The MK3 Cooling fan is also updated to be a bit sturdier. It should still work on anyone with the older V1 carriage. To reduce the confusion of the project, older files are removed from thingiverse but will be available via [github if needed](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/tree/master/STLs%20Titan%20Aero%20Conversion/Retired%20Versions).


1.3 Prusa MK3 R3 Update.  A number of fixes and improvements. This includes a new part cooling shroud based on the Prusa MK3 R3. It shows noticeable improvements over the old Prusa shroud. The issues that some people have had with the clearance of the shroud in relation to the nozzle should also be fixed. The x carriage rear plate has also been strengthened to improve rigidity.



### Download 

Downloadable on [thingiverse](https://www.thingiverse.com/thing:2744724)