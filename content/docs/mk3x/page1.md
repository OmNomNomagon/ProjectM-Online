---
title:  1.1 Bill Of Materials
linktitle: 1.1 Bill Of Materials
toc: true
type: docs
date: "2019-05-05T00:00:00+01:00"
draft: false
menu:
  MK3x:
    parent: 1. Pre-Assembly
    weight: 1

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 2
---

Total BOM is approx 100-150USD. However this is highly dependent on what you have laying around, where you source your parts from, what you want to carry over, and where in the world you are. A lot of my costs in Australia were shipping related.

I recommend Misumi for the core parts and will provide part numbers for each of those. Misumi regularly have a 30% off code for first time orders, which helps to keep costs down. For everything else cheap Ebay / Aliexpress parts will do. Many of the printed parts are designed around the Misumi plate bracket hole spacings. If you can’t source these parts (as misumi can be a pain to order from if you are outside of the US), I have another Thingiverse remix filled with tabbed printed brackets. These definitely won't be as strong or sturdy as the proper metal braces however. 
  

#### Summarised Parts List:

 

| Part 	| Description |	 Number Reqd | 
| --------------------- 	| ---------------------------------------- |	 ---------------------------------- | 
| 3030 Extrusion 355mm 	| Z Axis [HFSLB6-3030-355](https://sg.misumi-ec.com/vona2/detail/110302686450/?HissuCode=HFSLB6-3030-355) |	 2 | 
| 3030 Extrusion 350mm 	| Y Axis [HFSLB6-3030-350](https://sg.misumi-ec.com/vona2/detail/110302686450/?HissuCode=HFSLB6-3030-350) |	 2 | 
| 3030 Extrusion 380mm 	| X Axis Tower [HFSLB6-3030-380](https://sg.misumi-ec.com/vona2/detail/110302686450/?HissuCode=HFSLB6-3030-380) |	 2 | 
| 3030 Extrusion 258mm 	| X Axis Base [HFSLB6-3030-258](https://sg.misumi-ec.com/vona2/detail/110302686450/?HissuCode=HFSLB6-3030-258) |	 2 | 
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
| M3 Nylock 	| Nut for part cooling and heat sert substitute |	 1 - 15 | 
| M5 Smooth Idler Pulley 	| (Optional) 9mm wide replacement |	 2 | 
| M5 Fibrous Washers 	| For idler Pulleys |	 3 - 10 | 
| GT2 Belt 	| 6mm belt |	 1m | 
| 50mm Blower 	| Part Cooling |	 1 | 
| M3n Square nut 	| X motor tensioner (optional) |	 2 |


		

#### In Depth Descriptions:

- A Wanhao i3 Duh! (these parts will also allow you to upgrade most other prusa style printers, just adjust the lengths of your printer compared to the Wanhao’s smooth rods (X=320mm Z=320mm Y=380mm)

- Various 3030 T-slot Aluminium Extrusions
   - 2x 380MM - Tower X - HFSLB6-3030-380
   - 2x 355MM - Tower Z - HFSLB6-3030-355
   - 2x 350MM - Base Y - HFSLB6-3030-350
   - 2x 258MM - Base X - HFSLB6-3030-258

- 14x Corner Brackets 30x30x25 - Importantly these should be reversible or only be tabbed on one side! We are stacking two extrusions perpendicular on top of eachother. If they are fully tabbed on both sides they will NOT fit. HBLFSNB6 with low profile T-nuts or the single tabbed version HBLFSNK6.

![](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/2%20Bottom%20Frame/CornerBracket.JPG?raw=true)

- 8x Aluminium Corner plates with 4 mounting holes. The legs and printed corner parts are all based on the misumi hole spacing HPTLS6.

- 4x LM8UU Bearings. These replace the stock Z bearings. It is also worthwhile purchasing some of the longer LM8LUU bearing to replace the X and Y axises if you are coming from a pre 2.1 wanhao. These misumi ones are much higher quality than the originals. LMU8, LMUW8.

- 70x M5 12mm Button head screws

- 10x M5 16mm Button head screws

- 80 M5 T-Nuts. Drop in T-nuts are recommended as they are easier to work with. Some drop in T-Nuts have a longer neck which can cause issues with the Misumi HBLFSNB6 corner brackets. One side of the bracket is protruded, so that even when screwed in very tightly they don't apply enough compression force to secure the frame. In this case 14 T-nuts can be substituted with flat style ones, or pieces of fibre washers can be glued into the grooved areas to reduce the protrusion depth. Misumi also have t-nuts designed specifically for this bracket HNTT6-5. 14 of these can be used.

![Tnut mod for corner brackets protrusions](https://raw.githubusercontent.com/OmNomNomagon/ReDuplicator-MK3x/master/Pics/1%20Glamor%20Shots/Tnutmod.jpg)

- 1x M5 20-25 mm Button Head screw (low profile) The head needs to be 4.2mm or less long as this sits between the idler part and the leadscrew.

- 1x M5 30-35mm screw

- 22x [M3 Heat-sert Brass inserts (M3-UHBRHESF)](http://au.element14.com/tr-fastenings/m3-uhbrhesf/brass-insert-unheaded-m3/dp/2474921) W4.4mm x H5.8mm or similar. These are set into parts using a hot soldering iron and are great for making strong functional parts without having to worry about screw threads stripping over time. Proper thermal inserts are recommended, but the easier to source [injection molding type](https://www.aliexpress.com/item/100pcs-lot-Brass-insert-M2-M2-5-M3-Through-thread-brass-insert-nut-knurled-nuts/32840519444.html?ws_ab_test=searchweb0_0%2Csearchweb201602_4_10065_10344_10068_10130_10342_10547_10343_10340_10548_10341_10084_10617_10616_10083_10615_10307_10131_5920011_10132_10133_10313_10059_10534_100031_10604_10103_441_442_10142%2Csearchweb201603_25%2CppcSwitch_5&algo_expid=8c4388f4-62b7-4382-967f-2699a075ba66-0&algo_pvid=8c4388f4-62b7-4382-967f-2699a075ba66&priceBeautifyAB=2) ones should work almost as well.

- 7x 4-8mm M3 Button head

- 6x 12mm M3 Button head

- 6x 16mm M3 Button head

- 3x 30mm M3 screw

- 4x 6-8mm M3 countersunk

- 8x 6-12mm countersunk (for leadscrew nuts) you also may want to secure these with nylocks m3 x8

- 2x M5 Nylock nut

- 1x M3 Nylock for part cooling bracket. 6 more can be used as a substitute for the extruder assembly if Heat-serts cannot be found.

- Some fasteners are carried across from the Wanhao. This includes the hotend screws, and the M4 x-carriage screws.

- (Optional) 2x M5 Smooth Idler Pulleys. The original Wanhao pulleys are prone to failure over time and are 11mm wide. i recommend switching them out with new ones while doing this mod. Most replecement ones are 9mm wide which allows you to use the **X Gantry Idler 9MM** part instead of the **X Gantry Idler 11mm (Stock idler)** part. The 9mm version has thicker walls which should make it more durable over time.

- 3-10 M5 washers (Steel or fibrous). Used to secure the X and Y idlers. Variable number required depending on their thickness and whether you are using stock idlers or the usually thinner aftermarket ones.

- 1 Meter of GT2 6mm belt. The X carriage distances are increased and the stock belt may not be long enough. aprox 770mm is required. 

- 50mm Blower Fan. Hopefully you should already have one of these in your arsenal as they make a huge improvement to print quality

![Fasteners required](https://github.com/OmNomNomagon/ReDuplicator-MK2sx/blob/master/Pics/2%20Bottom%20Frame/Fasteners.jpg?raw=true)





### Summarised Misumi Parts List

- HFSLB6-3030-355	2
- HFSLB6-3030-380	2
- HFSLB6-3030-350	2
- HFSLB6-3030-258	2
- HPTLS6		8
- HBLFSNB6	14
- LMU8		4

Notes:
Substitute with HFSL6-3030 if you would like non anodized silver
HFS-3030 (Standard) or any other type of 3030 can be substituted instead.




### Essential Tools

- Set Square, ruler, measuring tape. - to ensure everything is a flush 90 degrees
- Calipers, to accurately offset parts
- Xacto Knife to clean prints
- soldering iron to insert the brass heat-serts
- 3mm, 5mm, 8mm and 15mm Drill bits. Depending on your filament, screw, rod and bearing holes may be slightly undersized. Running these drill bits through these holes ensures proper sizing. 
