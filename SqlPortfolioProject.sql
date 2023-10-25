SELECT * FROM [ PortfolioProject]..CovidDeaths
ORDER BY location,date

SELECT * FROM [ PortfolioProject]..CovidVaccinations
ORDER BY location,date

--Alter table CovidVaccinations
--Alter column people_vaccinated FLOAT;

-- Selecting Data that we will be using

SELECT location,date,population,total_cases,new_cases,total_deaths 
FROM CovidDeaths
ORDER BY location,date

--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if a person gets covid in their country

SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 [DeathPercentage]
FROM CovidDeaths
ORDER BY location,date

--Looking at Total Cases vs Population
--Shows what percentage of population got covid

SELECT location,date,total_cases,population,(total_cases/population)*100 [PopulationInfected(%)]
FROM CovidDeaths
WHERE location like 'India'
ORDER BY location,date

--Looking at countries with highest infection rate with respect to their population

SELECT location, population, MAX(total_cases) [HighestInfectionCount], MAX((total_cases/population))*100 [PopulationInfected(%)]
FROM CovidDeaths
GROUP BY location,population
ORDER BY [PopulationInfected(%)] DESC

--Showing Countries with Highest Death Count per Population

SELECT location, MAX(total_deaths) [TotalDeathCount]
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

--Showing Continents with Highest Death Count per Population

SELECT continent, MAX(total_deaths) [TotalDeathCount]
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

--Showing Globally

SELECT date, SUM(total_cases)[Total_cases], SUM(total_deaths) [Total_deaths], SUM(total_deaths)/SUM(total_cases)*100 [DeathPercentage]
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date,Total_cases    

--Joining CovidDeaths Table and CovidVaccinations Table

Select *
FROM CovidDeaths [death]
JOIN CovidVaccinations [vac]
ON death.location = vac.location
AND death.date = vac.date

--Looking at percentage of Total people vaccinated in each country

Select death.location, population, MAX(people_vaccinated) [TotalPeopleVaccinated], MAX(people_vaccinated)/population*100 [People_vaccinated(%)]
FROM CovidDeaths [death]
JOIN CovidVaccinations [vac]
ON death.location = vac.location
AND death.date = vac.date
WHERE death.continent IS NOT NULL
GROUP BY death.location,population
ORDER BY death.location,population DESC


















