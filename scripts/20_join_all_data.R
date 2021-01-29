### Preamble ###
# Purpose: Join all 20 datasets, 2000-2019, into one
# Author: Amy Farrow
# Contact: amy.farrow@mail.utoronto.ca
# Date: 2021-01-29
# Pre-requisites: None
# to-dos:


### Workspace setup ###
library(tidyverse)
library(janitor)
library(magrittr)
library(here)

### Merge datasets ###
cleaned_data <- 
  data_2019 %>%
  full_join(data_2018) %>%
  full_join(data_2017) %>%
  full_join(data_2016) %>%
  full_join(data_2015) %>%
  full_join(data_2014) %>%
  full_join(data_2013) %>%
  full_join(data_2012) %>%
  full_join(data_2011) %>%
  full_join(data_2010) %>%
  full_join(data_2009) %>%
  full_join(data_2008) %>%
  full_join(data_2007) %>%
  full_join(data_2006) %>%
  full_join(data_2005) %>%
  full_join(data_2004) %>%
  full_join(data_2003) %>%
  full_join(data_2002) %>%
  full_join(data_2001) %>%
  full_join(data_2000) 

### Save cleaned data ###
write_csv(cleaned_data, "inputs/data/cleaned_data.csv")
