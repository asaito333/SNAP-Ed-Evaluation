<img src="https://user-images.githubusercontent.com/29264214/27358784-0815d434-55cd-11e7-8ae9-957437f940dd.png" width="415" height="256" />

Introduction
--------------------

### Background

[Supplemental Nutrition Assistance Program](https://www.fns.usda.gov/snap/supplemental-nutrition-assistance-program-snap) (SNAP, formerly know as Food Stamp Program) is the largest domestic hunger safety net program in the United States. SNAP has proven power to increase households' purchasing power. However, it is not clear that if the SNAP participants eat nutritious meals that support their health considering [only a quarter of Americans follow recommended healthy eating patterns](https://health.gov/dietaryguidelines/2015/guidelines/chapter-2/current-eating-patterns-in-the-united-states/). This research addresses a question whether the additional income from SNAP transfers to healthier eating or not.

This is my thesis research. The research is funded by [The Arizona SNAP-Ed Evaluation team](https://nutritioneval.arizona.edu/) working under [Arizona Nutrition Network](https://www.eatwellbewell.org/), patnering with [ADHS](http://www.azdhs.gov/), [DES](https://des.az.gov/), and [USDA](https://www.usda.gov/).

### SNAP and SNAP-Ed
SNAP is designed to permit low-income households to access more nutritious and healthier diet through providing additional purchasing power. SNAP-Ed works with partners to provide food and nutrition education to support SNAP’s role in addressing food insecurity. While SNAP eligibility depends on individual's socioeconomic status, SNAP-Ed targets widely at people in low-income neighborhood through classes and projects.

### Goal
There are three goals in this research.

(1) Identify fruit and vegetable consumption pattern of people in Arizona


(2) Evaluate the effect of SNAP and SNAP-Ed on fruit and vegetable consumption
	
(3) Figure out the characteristics of SNAP participants

* Fruit and vegetable consumption is used to measure the healthy eating pattern
* (3) is not directly related with the evaluation, however, the result would be important information to design SNAP-Ed outreach


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

All analysis is conducted with sample weighting. 

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

