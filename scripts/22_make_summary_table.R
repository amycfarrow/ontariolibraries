library(tidyverse)
library(bookdown)    # for cross referencing figures and graphs; referencing
library(scales)      # for fixing date axes
library(DescTools)   # for capitalizing graph labels
library(lubridate)   # extract month from date_scored
library(kableExtra)  # for nicer tables
library(magrittr)
library(gganimate)
library(gifski)
library(magick)

cleaned_data <- readr::read_csv(here::here("inputs/data/cleaned_data.csv"))

averages <- cleaned_data %>%
  filter(year != "NA", program_attendance != "NA",
         type != "Contracting Municipality", type != "Contracting LSB", type!= "Contracting First Nations Band Council", type != "Contracting Indian Band Council",
         population > 0) %>%
  group_by(year) %>%
  summarise(name = "Provincial Average", 
            type = "Average", 
            population = sum(population), 
            num_cardholders = sum(num_cardholders), 
            program_attendance = sum(program_attendance))

graph_data <-
  cleaned_data %>%
  select(year, name, type, population, num_cardholders, program_attendance) %>%
  full_join(averages) %>%
  filter(year != "NA", 
         program_attendance != "NA",
         population > 0,
         num_cardholders != "NA",
         type != "Contracting Municipality", type != "Contracting LSB", type!= "Contracting First Nations Band Council", type != "Contracting Indian Band Council",
  ) %>%
  mutate(cardholders_per_thousand = 1000 * num_cardholders / population,
         program_attend_per_thousand = 1000 * program_attendance / population)


graph_data %>%
  filter(type == "Average") %>%
  select(year, population, num_cardholders, program_attendance, cardholders_per_thousand, program_attend_per_thousand) %>%
  knitr::kable(booktabs = TRUE,
               col.names = c("Year", "Population", "Cardholders", "Yearly program attendance", "Cardholders", "Yearly program attendance")) %>%
  add_header_above(c("", "Totals" = 3, "Per thousand" = 2), align = "l") %>%
  kable_styling() %>%
  as_image()