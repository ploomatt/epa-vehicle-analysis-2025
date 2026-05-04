# EV vs ICE Vehicle Analysis: 2025 EPA Data

Description:
>This project analyzes 2025 EPA Fuel Economy data comparing Electric Vehicles (EV) and Internal Combustion Engine (ICE) vehicles across cost, efficiency, and emissions using Python, SQL, Excel, and Power BI.

---

## Project Overview

#### Motivation
>With the growing adoption of electric vehicles, this project aims to use data analysis techniques to objectively compare EVs and ICE vehicles across three key dimensions: fuel cost, energy efficiency, and environmental impact. By working with real EPA data, this analysis uncovers measurable differences between the two vehicle types that reflect real world ownership considerations.

#### Technologies Used
>- Python (pandas): Data cleaning and preparation of raw EPA CSV files.<br>
>- SQL: Data querying and analysis using SQL Server Management Studio (SSMS) for aggregating, filtering, and comparing datasets.<br>
>- Excel: Pivot tables, comparison sheet, and 5 year fuel cost model using Power Query.<br>
>- Power BI: Interactive 4 page dashboard for visual storytelling and data exploration.

#### Features
>The analysis is designed to explore key differences between EVs and ICE vehicles across multiple dimensions.
>>- Fuel cost comparisons by vehicle class reveal how much more expensive ICE vehicles are to operate annually.<br>
>>- Efficiency comparisons using MPGe vs MPG highlight the significant performance gap between EV and ICE powertrains.<br>
>>- Emissions analysis quantifies the CO2 and GHG rating differences between the two vehicle types.<br>
>>- Brand level analysis identifies which manufacturers lead in efficiency, range, and environmental performance.<br>
>>- A 5 year fuel cost model built in Excel projects long term savings using EPA dataset averages.

---

## Data

#### Data Source
>2025 EPA Fuel Economy Guide — United States Environmental Protection Agency.<br>
>>https://www.fueleconomy.gov/feg/download.shtml<br>
>The raw data files are attached in the `Data/` folder as CSV files.

#### Data Structure
>The data is structured in a flat file format, with each record representing fuel economy statistics for a specific vehicle configuration. Key columns in the dataset include:<br>
>>- Brand / Model: The manufacturer and model name of the vehicle.<br>
>>- Vehicle_Class: The EPA classification of the vehicle (e.g., Compact Cars, Standard SUV 4WD).<br>
>>- Combined_MPGe / Combined_MPG: The combined fuel efficiency rating in miles per gallon equivalent for EVs, and miles per gallon for ICE vehicles.<br>
>>- Annual_Fuel_Cost: The estimated annual fuel cost based on average driving patterns and fuel prices.<br>
>>- GHG_Rating: The EPA greenhouse gas rating on a 1-10 scale, where 10 is best.<br>
>>- Combined_CO2: The combined CO2 emissions in grams per mile (tailpipe only).<br>
>>- Range_Miles_Combined: The combined driving range in miles for EV vehicles.<br>

#### Data Structure Continued...
>As part of the analysis, the raw EPA files required significant cleaning and preparation. The following steps were taken to produce analysis ready datasets:<br>
>>- Column selection: Reduced from 83 raw columns to 24 relevant columns per dataset.<br>
>>- Column renaming: Standardized column names to snake_case for compatibility across Python, SQL, Excel, and Power BI.<br>
>>- Whitespace removal: Stripped hidden leading and trailing spaces from column headers and cell values.<br>
>>- Null handling: Removed fully empty rows and rows where the Model column was blank or whitespace only.<br>
>>- Brand standardization: Consolidated duplicate brand entries (e.g., Lucid and Lucid USA Inc.) into a single consistent name.<br>
>>- A combined EV + ICE table was created in Power BI using Power Query append to enable side by side comparisons across both datasets.

---

## Results and Insights

>The project uncovers significant differences between EVs and ICE vehicles across cost, efficiency, and emissions.<br>
>Key insights include the dramatic fuel cost advantage of EVs, their zero tailpipe emissions, and the brands leading the transition to electric mobility.<br>
>>EVs cost on average **$942 per year** to fuel vs **$2,642 per year** for ICE vehicles — ICE vehicles cost more than double to operate annually.<br>
>>EVs produce **zero tailpipe CO2 emissions** compared to an ICE average of **400 grams per mile**.<br>
>>Lucid leads all EV brands in efficiency at **72.4 MPGe** with an average range of **422 miles**.<br>
>>Bugatti has the highest CO2 output of any ICE brand at **943g per mile** with a GHG rating of just **1 out of 10**.<br>
>>The EPA 5 year savings average for EVs is **$4,854** compared to most ICE vehicles which carry an extra spend figure rather than a savings figure — indicating most ICE vehicles cost more to fuel than the EPA baseline average.
