# 03/30/2022
# Nicholas Youngkrantz
# Covid-19 Data project

# Install packages /////////////////////////////////////////
install.packages("tidyverse")
install.packages("data.table")

# Load Libraries //////////////////////////////////////////
library(tidyverse)
library(data.table)

#///////////////////////////////////////////////////////////////////////////////////////
# I need to tidy up the covid location & population data file
# There is currently one row per date for every country
# Other than the date column, the data in each row is the same for each country
# I'm going to remove the duplicate data

# Load .CSV file //////////////////////////////////////////

Covid_Loc_Data = fread("C:/Users/Owner/Documents/Data Analysis Coursework/Data Analyst CV Projects/Covid Location & Population data.csv", 
                       header = TRUE,
                       sep = ",")

Covid_Loc_Data %>% glimpse

# Remove date column ///////////////////////////////////////

Covid_Loc_Data = Covid_Loc_Data %>% select(!date)

# Remove duplicate rows ////////////////////////////////////

Covid_Loc_Data = Covid_Loc_Data %>% distinct()

Covid_Loc_Data %>% glimpse

# Went from 172,799 rows to 239 as desired :)
# Write to CSV /////////////////////////////////////////////

write.csv(Covid_Loc_Data, 
          "C:/Users/Owner/Documents/Data Analysis Coursework/Data Analyst CV Projects/Covid Location & Population data small.csv",
          row.names = FALSE,
          na = "")

#//////////////////////////////////////////////////////////////////////////////
# I need to tidy up the Covid Excess Mortality data file
# There are many rows with blank mortality data
# I've checked the .CSV file and there is no instance where any mortality data is blank and other mortality data is recorded
# I'm going to remove the rows with blank mortality data

# Load .CSV file //////////////////////////////////////////////////

Covid_Mort_Data = fread("C:/Users/Owner/Documents/Data Analysis Coursework/Data Analyst CV Projects/Covid Excess Mortality data.csv", 
                        header = TRUE,
                        sep = ",")

Covid_Mort_Data %>% glimpse

# Removing blank rows /////////////////////////////////////////

Covid_Mort_Data = Covid_Mort_Data %>% filter(excess_mortality != "NA")

Covid_Mort_Data %>% glimpse

# Went from 172,799 rows to 6023 as desired :)
# Write to .CSV //////////////////////////////////////////////

write.csv(Covid_Mort_Data, 
          "C:/Users/Owner/Documents/Data Analysis Coursework/Data Analyst CV Projects/Covid Excess Mortality data small.csv",
          row.names = FALSE,
          na = "")
