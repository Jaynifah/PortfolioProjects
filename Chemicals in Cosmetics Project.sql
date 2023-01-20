
--1. Chemicals used the most in Cosmetics and Personl Care Products (Top 5)
SELECT DISTINCT ChemicalName, COUNT(ChemicalName) Occurence
FROM [Chemicals_in_cosmetics-]
WHERE PrimaryCategory = 'Personal Care Products'
GROUP BY ChemicalName
ORDER BY Occurence DESC
OFFSET 0 rows
FETCH next 5 rows only

--2. Find out which companies used the most reported chemicals in their cosmetics and personal care products.
--CTE was used to fetch top 5 reported chemicals, then a select statement to find which companies used those chemicals
WITH CTE_CHEMS AS (
SELECT DISTINCT ChemicalName, COUNT(ChemicalName) Occurence
FROM [Chemicals_in_cosmetics-]
WHERE PrimaryCategory = 'Personal Care Products'
GROUP BY ChemicalName
ORDER BY Occurence DESC
OFFSET 0 rows
FETCH next 5 rows only
)
SELECT DISTINCT CiC.CompanyName, CTE.ChemicalName
FROM [Chemicals_in_cosmetics-] CiC
JOIN CTE_CHEMS CTE
ON CiC.ChemicalName = CTE.ChemicalName


--3. Brands with chemicals that were removed and discontinued
SELECT BrandName, ChemicalName
FROM [Chemicals_in_cosmetics-]
WHERE DiscontinuedDate IS NOT NULL AND ChemicalDateRemoved IS NOT NULL
ORDER BY BrandName

--4. Brands with Chemicals that were mostly reported in 2018
SELECT DISTINCT BrandName, COUNT(BrandName) TimesReported
FROM [Chemicals_in_cosmetics-]
WHERE ChemicalCreatedAt LIKE '%2018%' 
GROUP BY BrandName  
ORDER BY TimesReported DESC