# Import Competition and Crime

## Objective
This study analyzes the effect of increasing import exposure of top six trading partners of the US on property and violent crimes for the period 1992-2006 at the commuting zone level. The study uses trade data from the UN Comtrade, crime data from the Uniform Crime Reports database issued by the Federal Bureau of Investigation and measures from the Census County of Business Pattern to create commuting zones.

## Codes
*1ImportDifference* : Computes three four-year differences in imports at the commodity level from the trading partners 

*2CleanCrime*: Feature engineers new property and violent crimes from Unified Crime Reports database and creates four year differences at the commuting-zone level

*3CZEmployments*: Finds the business employments at the commuting zone level from the County Business Pattern dataset

*4ExposureProgram*: Uses the UN Comtrade database and merge it the commuting zone employments to create a proxy for import exposure from each county for the given time periods

*5UnemploymentProgram*: Matches unemployment at the county level with the commuting zones created to find unemployment at the commuting zone level

*6FinalData*: Merges all the dataset at the commuting zone level to output a clean dataset to run the models

## Paper
*ImportCompeitionCrime* paper provides the literature review, data cleaning and preprocessing to study the effect of import competition on crime
