-- DATA  CLEANING --

SELECT 
    *
FROM
    layoffs;

-- 1. Removing Duplicates
-- 2. Standardize the Data
-- 3. NULL Values or blank values
-- 4. Remove any columns (Blank or Irrelevant)

-- Removing Duplicates --

CREATE TABLE layoffs_staging LIKE layoffs;

SELECT 
    *
FROM
    layoffs_staging;

insert into layoffs_staging select * from Layoffs;


select *,
ROW_NUMBER() Over
( partition by company, location, industry, total_laid_off, 
percentage_laid_off, 'date', stage, country, funds_raised_millions)as row_num
from layoffs_staging;


CREATE TABLE `layoffs_staging2` (
    `company` TEXT,
    `location` TEXT,
    `industry` TEXT,
    `total_laid_off` INT DEFAULT NULL,
    `percentage_laid_off` TEXT,
    `date` TEXT,
    `stage` TEXT,
    `country` TEXT,
    `funds_raised_millions` INT DEFAULT NULL,
    `row_num` INT
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

insert into layoffs_staging2
select *,
ROW_NUMBER() Over
( partition by company, location, industry, total_laid_off, 
percentage_laid_off, 'date', stage, country, funds_raised_millions)as row_num
from layoffs_staging;


select count(*)
from layoffs_staging2;


DELETE FROM layoffs_staging2 
WHERE
    row_num > 1;

SELECT 
    *
FROM
    layoffs_staging2
WHERE
    row_num > 1; 


SELECT 
    *
FROM
    layoffs_staging2;


--  'Standardizing the Data' --

SELECT 
    company, TRIM(company)
FROM
    layoffs_staging2;

UPDATE layoffs_staging2 
SET 
    company = TRIM(company);

SELECT 
    *
FROM
    layoffs_staging2
WHERE
    industry LIKE 'crypto%';

UPDATE layoffs_staging2 
SET 
    industry = 'crypto'
WHERE
    industry LIKE 'crypto%';

SELECT DISTINCT
    industry
FROM
    layoffs_staging2;

  

SELECT DISTINCT
    country
FROM
    layoffs_staging2
ORDER BY 1;


UPDATE layoffs_staging2 
SET 
    country = TRIM(TRAILING '.' FROM country)
WHERE
    country LIKE 'United States%'
;

SELECT 
    *
FROM
    layoffs_staging2;
    
SELECT 
    date
FROM
    layoffs_staging2;
    
    
UPDATE layoffs_staging2 
SET 
    date = STR_TO_DATE(date, '%m/%d/%Y');

alter table layoffs_staging2
modify column date date;


SELECT 
    *
FROM
    layoffs_staging2;
    

-- NULL Values or blank values --

select *
from layoffs_staging2
where company = 'Airbnb';

update layoffs_staging2
set industry = null
where industry = '';


select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;


select * from layoffs_staging2 where industry is null;
    
select * from layoffs_staging2 order by 1;

select * from layoffs_staging2 where stage = 'Post-IPO';
select count(*)
from layoffs_staging2;

select count(*)
from layoffs;

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;
 
 select * from layoffs_staging2 ;
 
alter table layoffs_staging2
drop column row_num;


---------- Project Data Cleaning done ---------