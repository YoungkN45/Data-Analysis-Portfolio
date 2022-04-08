# 04/07/2022
# Nicholas Youngkrantz
# Covid-19 Data project Analysis

# Install packages /////////////////////////////////////////
install.packages("tidyverse")
install.packages("data.table")

# Load Libraries //////////////////////////////////////////
library(tidyverse)
library(data.table)


#/////////////////////////////////////////////////////////////////////////
# I'm going to create a few visualizations to analyze covid case rates
# and population density

# Load .CSV file //////////////////////////////////////////////

cvd_cr_pop = fread("C:/Users/Owner/Documents/Data Analysis Coursework/Data Analyst CV Projects/Covid case rate & death rate per population per country.CSV", 
                        header = TRUE,
                        sep = ",")

cvd_cr_pop %>% glimpse

cvd_cr_pop %>% summary

# need to change population_density from character to numeric ////////////////

cvd_cr_pop <- cvd_cr_pop %>% 
  mutate(population_density = as.numeric(population_density))

# NA's introduced via mutate /////////////////////////////////////////////

cvd_cr_pop %>% filter(is.na(population_density))

# Some population_density NA's are for continents and income levels
# A few countries like Syria, Taiwan, and South Sudan don't are also NA
# I'm going to keep these out of the visualizations
# There should still be enough countries w/ data to see a clear pattern or no pattern

#/////////////////////////////////////////////////////////////////////////////////////////////
# visualizations /////////////////////////////////////////////////////////////////////////////

# I want to highlight the US on the scatter plot
# I'm creating a data frame w/ just US data

US <- cvd_cr_pop %>% filter(location == 'United States')

US

#////////////////////////////////////////////////////////////////////////////////////////
# Creating function to create a scatter plot of population_density V Case_Rate_%_Per_Pop
# One variable to set the MAX population density, default is largest pop_density
# Exclusively uses cvd_cr_pop dataframe created above
# Adds a larger red point for the US
# Adds a blue linear line of best fit

max(cvd_cr_pop$population_density, na.rm = TRUE)

pdcr_Scatter <- function(max_pop_dens = max(cvd_cr_pop$population_density, na.rm = TRUE)){
  cvd_cr_pop %>% 
    filter(!is.na(population_density),
           population_density < max_pop_dens) %>%
    ggplot(aes(x = population_density, y = `Case_Rate_%_Per_Pop` )) +
    geom_jitter(alpha = 0.5) +
    geom_point(data = US, color = "red", size = 5, alpha = 0.75) +
    geom_smooth(method = 'lm', color = "blue", se = FALSE)
}

# Scatter plot of all data except NA pop_densities ////////////////////////////////////////

pdcr_Scatter()

# Monaco and Macao are outliers with pop_density > 10000 ///////////////////////////////////////////
# Scatter plot without these data points ///////////////////////////////////////////////////////////

cvd_cr_pop %>% filter(population_density > 10000)

pdcr_Scatter(max_pop_dens = 10000)


# Singapore and Hong Kong are outliers w/ pop_density > 5000 ///////////////////////////////////////
# Scatter plot without these data points ///////////////////////////////////////////////////////////

cvd_cr_pop %>% filter(population_density > 5000,
                      population_density < 10000)

pdcr_Scatter(max_pop_dens = 5000)

# Gibraltar is an outlier w/ pop_density > 2000 ////////////////////////////////////////////////////
# Scatter plot without these data points ///////////////////////////////////////////////////////////

cvd_cr_pop %>% filter(population_density > 2000,
                      population_density < 5000)

pdcr_Scatter(max_pop_dens = 2000)

# Maldives, Bahrain, Bermuda, Malta & Bangladesh have pop_density > 1000 ///////////////////////////
# Scatter plot without these data points ///////////////////////////////////////////////////////////

cvd_cr_pop %>% filter(population_density > 1000,
                      population_density < 2000)

pdcr_Scatter(max_pop_dens = 1000)

# Regardless of how many outliers we remove, the data shows the same picture
# Countries with larger population densities tend to have higher covid rates
# Looking at the linear line of best fit shows a positive correlation between
# covid case rates and population densities
# We can also see a cluster of countries with low population density and 
# low covid case rates at the bottom left corner of the graph
# The US has a higher # of covid cases than countires with similar population density
# Many countries with higher population density than the US also have lower covid case rates