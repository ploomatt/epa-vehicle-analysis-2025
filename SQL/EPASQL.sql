-- EV vs ICE Vehicle Analysis 
-- Tables: EPA_EV_Clean, EPA_FE_Ratings_Clean
-- Author Mathew Gueon

--1. How many vehicles are in each dataset presented?
SELECT 'EV' AS Vehicle_Type, COUNT(*) AS Total_Vehicles
	FROM ProjectEPA.dbo.EPA_EV_Clean
UNION ALL
SELECT 'ICE' AS Vehicle_Type, COUNT(*) AS Total_Vehicles
	FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
	-- Vehicle_Type  Total_Vehicles
	-- EV            665
	-- ICE           868

--2. What vehicle classes exist in each dataset?
--a) EV
SELECT DISTINCT Vehicle_Class
	FROM ProjectEPA.dbo.EPA_EV_Clean
	ORDER BY Vehicle_Class
	-- 18 Vehicle classes 
--b) ICE
SELECT DISTINCT Vehicle_Class
	FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
	ORDER By Vehicle_Class
	--20 Vehicle classes

--3. Avg Annual fuel cost by vehicl class(EV vc ICE)
SELECT Vehicle_Type, Vehicle_Class, ROUND(AVG(Annual_Fuel_Cost), 0) AS Avg_Annual_Fuel_Cost
FROM (
	SELECT 'EV' AS Vehicle_Type, Vehicle_Class, Annual_Fuel_Cost
   FROM ProjectEPA.dbo.EPA_EV_Clean
   UNION ALL
    SELECT 'ICE' AS Vehicle_Type, Vehicle_Class, Annual_Fuel_Cost
    FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
) AS Combined
GROUP BY Vehicle_Type, Vehicle_Class
ORDER BY Vehicle_Class, Vehicle_Type
	--EVs cost more than double less to fuel annually across all vehicle classes
	-- EV Compact Cars $910 vs ICE $2,249 | EV Large Cars $813 vs ICE $2,688


-- 4. Average 5 year savings (EV vs ICE)
SELECT Vehicle_Type, ROUND(AVG(Savings_5yr), 0) AS Avg_5yr_Savings
FROM (
   SELECT 'EV' AS Vehicle_Type, Savings_5yr
    FROM ProjectEPA.dbo.EPA_EV_Clean
    UNION ALL
    SELECT 'ICE' AS Vehicle_Type, Savings_5yr
    FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
) AS Combine
GROUP BY Vehicle_Type
ORDER BY Vehicle_Type
	--5 Year Savings:
	--EV	$4854
	--ICE	$1687
	--EVs save almost 3 times more than ICE vehicles over 5 years


--5. Avg MPG vs MPGe by vehicle class
SELECT Vehicle_Type, Vehicle_Class, 
       ROUND(AVG(Combined_MPG), 0) AS Avg_Efficiency
FROM (
    SELECT 'EV' AS Vehicle_Type, Vehicle_Class, Combined_MPGe AS Combined_MPG
    FROM ProjectEPA.dbo.EPA_EV_Clean
    UNION ALL
    SELECT 'ICE' AS Vehicle_Type, Vehicle_Class, Combined_MPG
    FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
) AS Combined
GROUP BY Vehicle_Type, Vehicle_Class
ORDER BY Vehicle_Class, Vehicle_Type
	-- minicompact cars at 72 MPGe for EVs vs 20 mpg for ICE
	-- 3.6 times more efficient
	-- MPGe (miles per gallon equivalent) used to compare EV efficiency against ICE MPG, as defined by the EPA

--6. Top 10 most efficient EV
SELECT TOP 10 Brand, Model, Combined_MPGe, Range_Miles_Combined
	FROM ProjectEPA.dbo.EPA_EV_Clean
	ORDER BY Combined_MPGe DESC
	--Lucid takes 6 out of 10 spots
	--Hyundai Ioniq 6 has 135 MPGe for a traditional automaker

--7. Top 10 most efficient ICE vehicles
SELECT TOP 10 Brand, Model, Combined_MPG, Annual_Fuel_Cost
	FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
	ORDER BY Combined_MPG DESC
	-- Toyota takes 6 out of 10 spots of most efficient ICE vehicles

-- 8. Average CO2 emissions by vehicle class (EV vs ICE)
SELECT Vehicle_Type, Vehicle_Class, 
       ROUND(AVG(Combined_CO2), 0) AS Avg_CO2
FROM(
    SELECT 'EV' AS Vehicle_Type, Vehicle_Class, Combined_CO2
    FROM ProjectEPA.dbo.EPA_EV_Clean
    UNION ALL
    SELECT 'ICE' AS Vehicle_Type, Vehicle_Class, Combined_CO2
    FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
) AS Combined
GROUP BY Vehicle_Type, Vehicle_Class
ORDER BY Vehicle_Class, Vehicle_Type
	--EV vehicles have no tailpipe emissions while ICE vehicles do, measured in grams of C02 for every mile driven.
	--EVs produce zero tailpipe emissions vs ICE averaging 300-450g of CO2 per mile
	--Note:EV emissions from electricity generation are not captured in this data

--9. Which ICE vehicle classes produce the most CO2?
SELECT Vehicle_Class, ROUND(AVG(Combined_CO2), 0) AS Avg_CO2
	FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
GROUP BY Vehicle_Class
ORDER BY Avg_CO2 DESC
	--Large trucks and SUVs dominate the high end of the chart
	--Two seaters are higher due to the inclusion of sports cars with high revving engines


--10. Which brands have the highest average GHG rating? (Greenhouse Gas emissions; 10 being best while 1 being worst)
SELECT Vehicle_Type, Brand, ROUND(AVG(GHG_Rating), 1) AS Avg_GHG_Rating
FROM (
    SELECT 'EV' AS Vehicle_Type, Brand, GHG_Rating
    FROM ProjectEPA.dbo.EPA_EV_Clean
    UNION ALL
    SELECT 'ICE' AS Vehicle_Type, Brand, GHG_Rating
    FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
) AS Combined
GROUP BY Vehicle_Type, Brand
ORDER BY Avg_GHG_Rating DESC
	--EV cars produce no GHG emissions
	--Hyundai have the lowest GHG emissions of ICE car manufacturers with a 5.9
	--Bugatti scores 1; lowest in dataset, reflecting performance-only supercar lineup

--11. Which brands lead in EV efficiency?
SELECT TOP 10 Brand, ROUND(AVG(Combined_MPGe), 1) AS Avg_MPGe, 
       ROUND(AVG(Range_Miles_Combined), 0) AS Avg_Range
	FROM ProjectEPA.dbo.EPA_EV_Clean
	GROUP BY Brand
	ORDER BY Avg_MPGe DESC
	--Lucid leads at 75.4 MPGe and 422 mile average range
	--Note:Lucid and Lucid USA Inc. are the same manufacturer registered under two names in the EPA dataset
	--Hyundai and Toyota show strong EV efficiency alongside EV native brands

--12. Top 20 EVs by range
SELECT TOP 20 Brand, Model, Range_Miles_Combined, Combined_MPGe
	FROM ProjectEPA.dbo.EPA_EV_Clean
	ORDER BY Range_Miles_Combined DESC
	--Lucid Dominates the Range 
	--Chevrolet rivals Lucid with their Silverado EV 8WT having 492 Miles of range combined.
	--Note: some models appear multiple times due to different equipment configs
	
--13. Average charge time by vehicle class
SELECT Vehicle_Class, 
       ROUND(AVG(TRY_CAST(Charge_Time_240V_hrs AS FLOAT)),1) AS Avg_240V_Charge_Hrs
	FROM ProjectEPA.dbo.EPA_EV_Clean
GROUP BY Vehicle_Class
ORDER BY Avg_240V_Charge_Hrs ASC\
	--Minicompact Cars have the lowest average charge time while
	--two seaters have the highest average charge time.

--14. EV vs ICE side by side comparison by vehicle class (JOIN)
SELECT 
    e.Vehicle_Class,
    ROUND(AVG(e.Combined_MPGe), 0) AS Avg_EV_MPGe,
    ROUND(AVG(i.Combined_MPG), 0) AS Avg_ICE_MPG,
    ROUND(AVG(e.Annual_Fuel_Cost), 0) AS Avg_EV_Fuel_Cost,
    ROUND(AVG(i.Annual_Fuel_Cost), 0) AS Avg_ICE_Fuel_Cost,
    ROUND(AVG(e.GHG_Rating), 1) AS Avg_EV_GHG,
    ROUND(AVG(i.GHG_Rating), 1) AS Avg_ICE_GHG
FROM ProjectEPA.dbo.EPA_EV_Clean e
JOIN ProjectEPA.dbo.EPA_FE_Ratings_Clean i 
    ON e.Vehicle_Class = i.Vehicle_Class
GROUP BY e.Vehicle_Class
ORDER BY e.Vehicle_Class
	-- EVs outperform ICE across all vehicle classes in every metric
	-- Higher MPGe, lower fuel cost, and perfect GHG rating of 10 across the board
	-- Note:Only 17 vehicle classes shown; JOIN excludes classes without an EV equivalent

--15. EV efficiency ranking within each vehicle class(Window Function)
SELECT Brand,Model,Vehicle_Class,Combined_MPGe,
    RANK() OVER (PARTITION BY Vehicle_Class ORDER BY Combined_MPGe DESC) AS Efficiency_Rank
	FROM ProjectEPA.dbo.EPA_EV_Clean
ORDER BY Vehicle_Class, Efficiency_Rank
	--BMW leads Compact Cars with 116 MPGe, Lucid leads Large Cars (146 MPGe)
	--rivian dominates electric trucks, Bugatti Rimac leads Two Seaters at 66 MPGe
	--Note: tied vehicles share the same rank, next rank is skipped


--16. EV vs ICE cost comparison using CTE
WITH EV_Avg AS (SELECT Vehicle_Class,
        ROUND(AVG(Annual_Fuel_Cost), 0) AS Avg_EV_Cost,
        ROUND(AVG(Savings_5yr),0) AS Avg_EV_Savings
		FROM ProjectEPA.dbo.EPA_EV_Clean
    GROUP BY Vehicle_Class),
ICE_Avg AS (SELECT Vehicle_Class,
        ROUND(AVG(Annual_Fuel_Cost),0) AS Avg_ICE_Cost,
        ROUND(AVG(Savings_5yr), 0) AS Avg_ICE_Savings
    FROM ProjectEPA.dbo.EPA_FE_Ratings_Clean
    GROUP BY Vehicle_Class)
SELECT 
    e.Vehicle_Class,
    e.Avg_EV_Cost,
    i.Avg_ICE_Cost,
    i.Avg_ICE_Cost - e.Avg_EV_Cost AS Cost_Difference,
    e.Avg_EV_Savings,
    i.Avg_ICE_Savings
	FROM EV_Avg e
JOIN ICE_Avg i ON e.Vehicle_Class = i.Vehicle_Class
ORDER BY Cost_Difference DESC
	--Minicompact Cars have the largest annual cost gap; EV $725 vs ICE $3,227 ($2,502 difference)
	--Every vehicle class shows EVs are cheaper to fuel annually
	--ICE Savings_5yr only populated for most efficient vehicles(hybrids or economy cars)
	--Most ICE vehicles have Extra_Spend_5yr instead, meaning that they cost more than the EPA baseline
