-- Data Exploration -- 

SELECT 
    *
FROM
    layoffs_staging2;
--------------------------------------------------------------------------    

-- maximum laid off employees--

select max(total_laid_off)
from  layoffs_staging2;

/* FINDINGS -> MAX OF 12000 employees were laid off in a single day */
--------------------------------------------------------------------------

-- maximum percentage laid off --

select max(percentage_laid_off)
from  layoffs_staging2;

/* FINDINGS -> 100% of the employees were laid off in a single day */
--------------------------------------------------------------------------

-- Total number of Companies who laid off 100% of their employees --

select count(company)
from layoffs_staging2
where percentage_laid_off = 1
;

/* FINDINGS -> 115 companies */
--------------------------------------------------------------------------

-- distinct count of companies in the table --

select  count(distinct company)
from layoffs_staging2;

/* FINDINGS -> 1631 companies */
--------------------------------------------------------------------------

-- COMPANIES WHERE THERE IS NO LAYOFFS --

select count(distinct company)
from layoffs_staging2
where percentage_laid_off = 0 and percentage_laid_off is not null
;

/* FINDINGS -> 1 company but there seems to be an issue as this company has a certain amount of total_laid_offs */

--------------------------------------------------------------------------

-- TOTAL NUMBER OF EMPLOYEES LAID OFF BY COMPANIES--

select company, sum(total_laid_off), location
from layoffs_staging2
group by company, location
order by 2 desc;

SELECT *
FROM layoffs_staging2
where company = 'Amazon';

/* FINDINGS -> Amazon laid off a total of 18150 employees in Seattle (in different months/years) */

--------------------------------------------------------------------------

-- WHEN THE LAYOFFS OCCURED?  -- 

SELECT min(date), Max(date)
from layoffs_staging2;

select year(date), sum(total_laid_off)
from layoffs_staging2
group by year(date)
order by 2 desc ;

/* FINDINGS -> Early 2020 till early 2023 (around the covid pandemic times) layoffs occurred, where 2022 saw the maximum number (160k approx.) of employees laid off around the globe 
but a total of 125k layoffs happened in just first 3 months of 2023 */

--------------------------------------------------------------------------

-- WHICH INDUSTRY WAS MOST/LEAST AFFECTED? --

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

/* FINDINGS -> Consumer & Retail industries were affected the most AND Manufacturing was affected the least  */

--------------------------------------------------------------------------

-- WHICH COUNTRY LAID OFF THE MOST EMPLOYEES? --

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select year(date), country
from layoffs_staging2
where country = 'UNITED STATES'
group by year(date), country
order by 1 asc ;

/* FINDINGS -> Industries in UNITED STATES were affected the most between 2020 & 2022 (Pandemic), hence a large amount of total layoffs  */

--------------------------------------------------------------------------

-- Determining the stage when most layoffs happened --

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc ;

select stage, company, industry, sum(total_laid_off)
from layoffs_staging2
where stage = 'POST-IPO'
group by stage, company, industry
order by 4 desc ;

/* FINDINGS ->  POST-IPO a total of 204k layoffs happened across different industries and companies with Amazon being on top of other companies to layoff the maximum of their employees */

--------------------------------------------------------------------------









