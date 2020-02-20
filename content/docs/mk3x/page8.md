---
title: 3.4 Headbed upgrade MK52
linktitle: 3.4 Headbed upgrade MK52
toc: true
type: docs
date: "2019-05-05T00:00:00+01:00"
draft: false
menu:
  MK3x:
    parent: 3. Hotends & Upgrades
    weight: 9

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 10
---



The final piece of recreating the Prusa MK3s magic is the fantastic removable spring steel PEI magnetic heatbed. Unfortunately the dimensions of the rods on the original Wanhao differ quite a lot from the MK3 and as such cannot accommodate the heatbed or fully utilize its larger build volume.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52Main.jpg?raw=true)


This project expands the ReDuplicator frame to enable full use of the Mk52 heatbed with its 254x210mm buildspace. This requires new extrusions and rods. Some extrusions and printed parts are carried over from the original ReDuplicator design.

### Printed Parts

Most of the instructions and printed parts carry over from the original ReDuplicator Design. However the following printed parts supersede the original ones.


|MK52 Printed Parts|
|-------------|
|Heatbed Cover Bottom MK52 Expansion 360	|
|Heatbed Cover Top MK52 Expansion 360  |
|X Gantry Idler 9MM - MK52 Expansion 360  |
|X Gantry Motor Mount - MK52 Expansion  |
|X Axis TMC Endstop 360  |
|Y Carriage Bearing Block - MK52 Expansion 360 |
|Y Carriage Bearing Block Flanged - MK52 Expansion 360  |
|Y Carriage Belt Holder - MK52 Expansion  |
|Y Carriage Belt Tensioner - MK52 Expansion  |
|Z Axis Motor Bottom Left - MK52 Expansion 360  |
|Z Axis Motor Bottom Right - MK52 Expansion 360  |
|Z Axis Rod Top Left Bracket - MK52 Expansion 360  |
|Z Axis Rod Top Right Bracket - MK52 Expansion 360  |

These are the recommended printed parts from the original Reduplicator Project

|Original Reduplicator Printed Parts | Details |
|------|------------|
|BLTouch Mount  | MK10 Hotend Only  |
|Base Leg H26.8mm 360 X4  |   |
|Cable Guide Alternate - Motor Mount 360  | New cable routing via X gantry motor|
|Cable Guide Bottom Mount 360  | New Recommended cable routing part|
|Inner Corner Bracket Covers X2  |
|Part Cooling Fan Bracket MK3 V3  | MK10 Hotend only |
|Part Cooling Fan MK3 R3 V3  | MK10 Hotend only |
|X Carriage Front Extruder Plate MK3 V2  | MK10 Hotend only |
|X Carriage Universal Rear Bearing Plate MK3 V3  | MK10 or Titan Aero Hotend only | 
|Y Axis Motor Mount V2 360  | Recently updated design |
|Y Axis Rod Holder Left 360 X2  | Recently updated design |
|Y Axis Rod Holder Right & Endstop  | Only Required If using endstop switches  |
|Y Axis Rod Holder Right 360  | Recently updated design |
|Z Rod Securer V2 360  |
|Z Tower Bottom Crossover Brackets 360  |
|Z Tower Top Corner Bracket V3 360 X2  | 
|Z-EndStop  | Only Required If not using a leveling probe  |


### Bill Of materials

The BOM remains largely the same apart from a the new extrusions, rods and a few additional fasteners. As usual I recommend Misumi extrusions, bearings and rods due to their exceptional quality. While purchasing new rods it's also a good idea to replace the bearings with [LMU8s](https://sg.misumi-ec.com/vona2/detail/110302577950/?HissuCode=LMU8) if you haven't already as they are tolerance matched.


| New Parts 	| Description |	 Number Reqd | 
| -----------------------------| ---------------------------------------- |---------------------------- |
| 3030 Extrusion 278mm 	| X Base [HFSLB6-3030-278](https://sg.misumi-ec.com/vona2/detail/110302686450/?HissuCode=HFSLB6-3030-278) |	 2 | 
| 3030 Extrusion 430mm 	| Z Tower [HFSLB6-3030-430](https://sg.misumi-ec.com/vona2/detail/110302686450/?HissuCode=HFSLB6-3030-430) |	 2 | 
| 3030 Extrusion 340mm 	| X Tower [HFSLB6-3030-340](https://sg.misumi-ec.com/vona2/detail/110302686450/?HissuCode=HFSLB6-3030-340) |	 2 | 
| Hardened Steel Rod 380mm  | X Axis Rods [PSFJ8-380.](https://sg.misumi-ec.com/vona2/detail/110302634310/?ProductCode=PSFJ8-380) Alternatively CPSFJ8-380 is cheaper with worse tolerances and hardness. Or PSFU8-380 with higher tolerances and a higher price |  2 |
| Hardened Steel Rod 330mm  | Z Axis Rods [PSFJ8-330](https://sg.misumi-ec.com/vona2/detail/110302634310/?ProductCode=PSFJ8-330) |  2|
| Hardened Steel Rod 370mm  | Y Axis Rods [PSFJ8-370](https://sg.misumi-ec.com/vona2/detail/110302634310/?ProductCode=PSFJ8-370) |  2|
| Prusa original MK52 heatbed Kit | Can be purchased directly from Prusa if you have a friend with a MK3, otherwise clones are widely available. |  1 |
| MK3 Y Carriage |  [6mm Aluminium](https://www.aliexpress.com/item/32882851897.html?spm=a2g0s.9042311.0.0.27424c4d8K3I5M) or a [lighter Composite version]( https://www.aliexpress.com/item/32991330262.html?spm=a2g0s.9042311.0.0.27424c4d8K3I5M)  |  1 |
| Heatbed 6mm Spacer Kit| [6mm spacer and 12mm M3 screws]( https://www.aliexpress.com/item/32961482490.html?spm=a2g0s.9042311.0.0.27424c4dnxrqP3) Recommend using 1 spacer for the center and using Nylocks on the other screws for a perfect bed level |  1 |
| M3 35mm | For Y carriage tensioner  | 1 |
| M3 22mm | To secure the bearings to the Y Carriage. | 6 |
| M3 Nylock | Additional nylocks required for heatbed leveling and mounting | 15-25 | 

The parts below carry over from the original ReDuplicator build.

| Carry Over Parts 	| Description |	 Number Reqd | 
|--------------------------|-------------------|------------------|
| 3030 Extrusion 355mm 	| Y Base [HFSLB6-3030-355](https://sg.misumi-ec.com/vona2/detail/110302686450/?HissuCode=HFSLB6-3030-355) Carried across from Old Z Axis|	 2 | 
| 30x30x35 Corner Brackets 	| Tabbed on SINGLE Side only [HBLFSNB6](https://sg.misumi-ec.com/vona2/detail/110300442340/?HissuCode=HBLFSNB6) |	 14 | 
| Alluminium Flat bracket 	| 4 mount holes [HPTLS6](https://sg.misumi-ec.com/vona2/detail/110302250620/?HissuCode=HPTLS6) |	 8 | 
| LM8UU Bearings 	| Std 8mm 15mm long bearings [LMU8](https://sg.misumi-ec.com/vona2/detail/110302577950/?HissuCode=LMU8) |	 4 | 
| M5 12mm  	| Button Head Screw M5 |	 70 | 
| M5 16mm 	| Button Head Screw M5 |	 10 | 
| M5 T-Nuts 	| 3030 T-Nuts Drop in preferred |	 80 | 
| M5 20-25mm 	| Low Profile Button head (less than 4.2mm) |	 1 | 
| M5 30-35mm  	| Screw M5 |	 1 | 
| M3 Heatserts 	| Brass heat inserts M3 thread [M3-UHBRHESF](http://au.element14.com/tr-fastenings/m3-uhbrhesf/brass-insert-unheaded-m3/dp/2474921) |	 22 | 
| M3 4-8mm 	| Button Head Screw M3 |	 8 | 
| M3 12mm 	| Button Head Screw M3 |	 6 | 
| M3 16mm 	| Button Head Screw M3 |	 6 | 
| M3 30mm 	| Screw M3 |	 3 | 
| M3 6-8mm 	| Countersunk M3 |	 4 | 
| M3 6-12mm 	| Countersunk M3 |	 8 | 
| M5 Nylock 	| Nuts for Idlers |	 2 | 
| M5 Smooth Idler Pulley 	| (Optional) 9mm wide replacement |	 2 | 
| M5 Fibrous Washers 	| For idler Pulleys |	 3 - 10 | 
| GT2 Belt 	| 6mm belt |	 1m | 
| 50mm Blower 	| Part Cooling |	 1 | 
| M3 Square nut 	| X motor tensioner |	 2 |


At this stage the [original ReDuplicator instructions](https://github.com/OmNomNomagon/ReDuplicator-MK3x/wiki) can be followed in conjunction with the changes listed below. The [original Prusa MK3s](https://manual.prusa3d.com/c/Original_Prusa_i3_MK3S_kit_assembly) guides are also a valuable resource.

### Assembly

The Base is made up of the 278mm Extrusions in the X direction and 355mm in the X Direction.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52Base.jpg?raw=true)

The underside crossbeam is a 340mm extrusion. Its final position depends on your exact setup so leave it slightly loose till the best of the build is finalized. For example, when using a Hemera hotend with TMC sensorless homing, the crossbeam should be 185mm from the front of the base. 

The Z Tower is made up of 430mm extrusions. In this version the vertical extrusion go all the way to the top and bottom, which makes it much easier to add the corner brackets and rod holding tower parts.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52Tower.jpg?raw=true)

The Z motor mounts should be mounted 42mm from the base of the Z tower.
The top of the Y axis Idler should be mounted 118mm across the front extrusion and the top of the Y motor mount should be 108mm across the rear extrusion. For the MK10 and Titan aero these can be set 10mm further to the right.

The 380mm rods are mounted on the Y axis, 330mm rods on the z axis and 370 rods in the Y axis.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52Rods.jpg?raw=true)

The Z Top Rod holding pieces should be flush with the edge and the top of the tower extrusions. The distance between the Z axis rods is 396mm.

The Y axis rods are press fit into the X idler and X motor pieces. There are small windows to ensure the rods are inserted fully.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52Bearings.jpg?raw=true)


Insert the bearings into the Y bearing holders. use the flanged bearing blocks if you are using normal LM8U bearings or use the non flanged version if using longer LM8UU bearings. M3 Nylocks are press fit into the blocks and secured to the Y carriage with 22mm-25mm M3 bolts and washers screwed in from the top.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52Carriage.jpg?raw=true)

The Y Belt holder requires 2 m3 nylocks to be press fit into it. It is mounted to the Y carriage on the side of the Y motor mount with a 10mm-12mm M3 bolt and nylock. The Y Belt Tensioner is attached to the other side and a nylock is press fit on the side. The belt is mounted by looping the belt around a 12mm m3 screw and slowly screwing it in. Once the belt is properly in the channels a 35mm M3 screw between the Belt holder and tensioner is tightened to tension the belt properly.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52YTension.jpg?raw=true)

The MK52 heatbed can then be installed. There are 9 mounting holes. Use the countersunk 12mm screw and 6mm spacer for the middle mount. For each of the other mounting holes use a 12mm countersunk M3 along with a nylock nut. This allows precise leveling of the heatbed.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52YComp.jpg?raw=true)

The heatbed must be soldered in order to be low profile enough that it doesn't collide with the hotend cooling system. Feed the wires from below through the holes and solder directly to the board trying to keep it as flat as possible. 

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52Heatbed.jpg?raw=true)

Install the heatbed cover using the fasteners provided with the heatbed. This should be 3x 10mm bolts and 3 M3 nuts.
If done correctly, the heatbed cover bump should be well below the extruder assembly and cooling fan during leveling and printing.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/11%20MK52%20Expansion/Mk52HeatClearance.jpg?raw=true)

The rest of the installation proceeds as a normal ReDuplicator build.