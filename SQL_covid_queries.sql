select * from Covid_Deaths;

-- selecting the data which is required for this project

select location , date , total_cases, new_cases, total_deaths , population 
from Covid_Deaths
order by 1,2;

-- total percentage of deaths in India

select location , date , total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percent
from Covid_Deaths
where location = 'India';

-- total percentage of deaths in world due to covid 

select location , date , total_cases, total_deaths, round((total_deaths/total_cases)*100, 2) as death_percent
from Covid_Deaths
order by 1;

-- Percentage of population got covid

select location , date , population, total_cases , round((total_cases/population)*100, 2) as Tested_positive
from Covid_Deaths
order by 1;

-- Percentage of population got covid in India

select location , date , population, total_cases , round((total_cases/population)*100,4) as Tested_positive
from Covid_Deaths
where location = 'India'
order by 1;

-- Looking at countries with highest infection rate compared to population

select location, population, max(total_cases) as hightest_cases, max(round((total_cases/population)*100,4)) as Tested_positive_percent
from Covid_Deaths
where continent is not null
group by location , population
order by 1;

-- countries with highest death count per population

select location, max(total_deaths) as Highest_deaths
from Covid_Deaths
where continent is not null
group by location
order by Highest_deaths desc;

-- continent with highest death count

select continent, max(total_deaths) as Highest_deaths
from Covid_Deaths
where continent is null
group by continent
order by Highest_deaths desc;

-- total death percentage all over the world

select sum(cast(new_cases as float)) as total_cases , sum(cast(new_deaths as float)) as total_deaths ,
sum(cast(new_deaths as float))/(sum(cast(new_cases as float))) * 100 as total_death_percent
from Covid_Deaths
where continent is not null;

-- population who got vaccinated

select deaths.continent, deaths.location, deaths.date, deaths.population, vaccine.new_vaccinations
from Covid_Deaths deaths
join Covid_Vaccinations vaccine
  on deaths.location = vaccine.location
  and deaths.date = vaccine.date
where deaths.continent is not null
order by 2,5 desc;