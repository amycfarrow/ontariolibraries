library(tidyverse)
library(bookdown)    # for cross referencing figures and graphs; referencing
library(scales)      # for fixing date axes
library(DescTools)   # for capitalizing graph labels
library(lubridate)   # extract month from date_scored
library(kableExtra)  # for nicer tables
library(magrittr)
library(gganimate)
library(gifski)

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

cardholdersprogram.animation <-
  ggplot(graph_data, aes(x = cardholders_per_thousand, 
           y = program_attend_per_thousand, 
           size = population, 
           color = type)
          ) +
  geom_point(alpha = 0.5) +
  scale_x_continuous(limits = c(0,1600), breaks = c(0,200,400,600,800,1000,1200,1400,1600)) +
  scale_y_continuous(limits = c(0,1000), breaks = c(0,200,400,600,800,1000)) +
  scale_size(trans = "log10") +
  theme_light(base_size = 24,
              ) +
  # gganimate specific bits:
  labs(title = "Ontario library cardholders compared to program attendance over time",
       subtitle = 'Year: {round(frame_time,0)}',  
       x = 'Cardholders per thousand', 
       y = 'Program attendance per thousand', 
       color = "Type of library",
       size = "Population served by library (logarithmically scaled)") +
  scale_color_manual(values = c("black", "violetred1", "darkorchid1","dodgerblue", "chartreuse3")) +
  transition_time(year) +
  guides(color = guide_legend(override.aes = list(size = 10))) +
  ease_aes('linear')

animate(cardholdersprogram.animation, height = 900, width = 1600, start_pause = 2, end_pause = 8, duration = 15)


# Save at gif:
anim_save(here::here("outputs/cardholders-program-ggplot2-animated3.gif"))