<img src="https://user-images.githubusercontent.com/29264214/27358784-0815d434-55cd-11e7-8ae9-957437f940dd.png" width="415" height="256" />

Introduction
--------------------

### Background

Supplemental Nutrition Assistance Program (SNAP, formerly know as Food Stamp Program) is the largest domestic hunger safety net program in the United States. It has been shown that SNAP increases households’ purchasing power. However, only a quarter of Americans follow recommended healthy eating patterns. Hence, there is a question whether the additional income from SNAP transfers to healthier eating.

This is my thesis project. This research is funded by [The Arizona SNAP-Ed Evaluation team](https://nutritioneval.arizona.edu/) working under [Arizona Nutrition Network](https://www.eatwellbewell.org/).


### Goal
There are three goals in this project
* Identify f&v consumption of people in Arizona
* Evaluate the effect of SNAP and SNAP-Ed on fruit and vegetable consumption
	create eligible group
	originally planning to use selection model
* Figure out the characteristics of SNAP participants
	this would be useful information to design the SNAP-Ed program

Data and Analysis
---------------------

### Dataset
* BRFSS - survey in Arizona, 2011 and 2013
* DES Office Distance - internal data
* SNAP-Ed contractor - internal data
* SNAP partner - internal data
* Grocery store - NAICS

### Data cleaning step
(1) Clean zipcode in BRFSS using ASC data
(2) Merge (2), (4), and (5) by zipcode
(3) Merge (3) by county

(4) Delete observations without fs and control variables
(5) Delete observations with outlier value of F&V
(6) Eligibility

### Analysis

(1) Fruits and Vegetable consumption in Arizona
- explain how to interpret the variable
- histogram
(t-test?)

(2) OLS on SNAP and SNAP-Ed
- simple OLS regression 
- only control, (i)grocery store (ii)SNAP-Ed contractor per poor population
Identified the marital status and SNAP-Ed.

(3) Probit model
- probit model
- used DES distance and SNAP partner
Identified DES distance is significant and SNAP partner is not.
prediction rate

Conclusion
--------------------
- state findings
- limitation: EARS data is desirable

