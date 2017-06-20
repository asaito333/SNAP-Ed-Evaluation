Introduction
--------------------

### Background
This is my thesis project. 
The research is funded by UA Nutriton Network

The eating pattern of people in US is going under the recommended guideline.
SNAP and SNAP-Ed helps together with people eating healthy.
This research evaluates how SNAP and SNAP-Ed actually affects on fruit and vegetable consumption in Arizona

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

