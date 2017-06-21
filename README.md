<img src="https://user-images.githubusercontent.com/29264214/27358784-0815d434-55cd-11e7-8ae9-957437f940dd.png" width="415" height="256" />

Introduction
--------------------

### Background

[Supplemental Nutrition Assistance Program](https://www.fns.usda.gov/snap/supplemental-nutrition-assistance-program-snap) (SNAP, formerly know as Food Stamp Program) is the largest domestic hunger safety net program in the United States. SNAP has proven power to increase households' purchasing power. However, it is not clear that if the SNAP participants eat nutritious meals that support their health considering [only a quarter of Americans follow recommended healthy eating patterns](https://health.gov/dietaryguidelines/2015/guidelines/chapter-2/current-eating-patterns-in-the-united-states/). This research addresses a question whether the additional income from SNAP transfers to healthier eating or not.

This is my thesis research. The research is funded by [The Arizona SNAP-Ed Evaluation team](https://nutritioneval.arizona.edu/) working under [Arizona Nutrition Network](https://www.eatwellbewell.org/), patnering with [ADHS](http://www.azdhs.gov/), [DES](https://des.az.gov/), and [USDA](https://www.usda.gov/). This README simplified the actual work of my thsis and focused only on significant results.

### SNAP and SNAP-Ed
SNAP is designed to permit low-income households to access more nutritious and healthier diet through providing additional purchasing power. SNAP-Ed works with partners to provide food and nutrition education to support SNAP’s role in addressing food insecurity. While SNAP eligibility depends on individual's socioeconomic status, SNAP-Ed targets widely at people in low-income neighborhood through classes and projects.


Goals
-----------------------
There are three goals in this research.

(1) Identify fruit and vegetable consumption patterns of people in Arizona

(2) Evaluate the effect of SNAP and SNAP-Ed on fruit and vegetable consumption
	
(3) Figure out the characteristics of SNAP participants

* Fruit and vegetable consumption is used to measure the healthy eating pattern
* Fruit and vegetable consumption is measured by frequency (how many times you eat ped day?), not amount
* (3) is not directly related with the evaluation, however, the result would be important information to design SNAP-Ed outreach


Data
---------------------

* [Behabioral Risk Factor Surveillance System (BRFSS)](http://azdhs.gov/preparedness/public-health-statistics/behavioral-risk-factor-surveillance/index.php#data-code-book) - Survey Data collected in Arizona in 2011 and 2013. 
* [Grocery store information: Census Bureau #CB1300CZ21](https://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml?pid=BP_2013_00CZ2&prodType=table) - Number of grocery store in each zip code area in 2011 and 2013. Link is 2013.
* DES Office Location - extracted from [DES office locator](https://eol.azdes.gov/)
* SNAP-Ed contractor - AZ SNAP-Ed contractors by county in 2011 and 2013, internal data


Analysis and Results
---------------------

### Analysis Setting
* Observations without SNAP status and control variables are omitted
* Observations with outliers in fruit and vegetable consumption: who answered to eat fruits more than 16 times and vegetables 23 times a day
* Created low-income subgroup based on [USDA SNAP eligibility criteria](https://www.fns.usda.gov/snap/eligibility)
* All analysis is conducted with sample weighting using SAS

### (1) Fruit and Vegetable consumption patterns in Arizona

* Fruit

![fruits](https://user-images.githubusercontent.com/29264214/27361798-ac59e4de-55de-11e7-841e-014bb2ea8677.png)

| Quartile | Min| Q1  | Median | Q3    | Max | Mean |
| ---------| -- |-----|--------|-------|-----|------|
| Value    |  0 |0.498|  1.006 | 1.965 | 14  |  1.42|

*The values in table are multipled by 100. ex. 300 = eat fruits 3 times a day*

* Vegetable

![vege](https://user-images.githubusercontent.com/29264214/27361794-a703be7e-55de-11e7-88b7-30a376d0fed5.png)

| Quartile | Min| Q1  | Median | Q3    | Max    | Mean |
| ---------| -- |-----|--------|-------|--------|------|
| Value    |  0 |1.033|  1.664 | 2.508 | 18.07  |  2.01|


* People in Arizona consume fruits 1.42 times and vegetables 2.01 times as daily average
* There is a significant difference in mean value of vegetable between low-income and non-low-income subgroups


### (2) The effect of SNAP and SNAP-Ed on fruit and vegetable consumption

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

