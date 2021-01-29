### Preamble ###
# Purpose: Importing and cleaning library data for the year 2011
# Author: Amy Farrow
# Contact: amy.farrow@mail.utoronto.ca
# Date: 2021-01-29
# Pre-requisites: None
# to-dos:


### Workspace setup ###
library(tidyverse)
library(janitor)  # for nicer tables
library(magrittr)
library(here)

### Get data ###
# data from https://open.canada.ca/data/en/dataset/363fff31-6a07-41eb-9922-e9b64192b08b#wb-auto-6
# downloaded January 29th 2021
data_2011 <- readr::read_csv(here::here("inputs/data/ontario_public_library_statistics_2011_open_data_may_22_csv_final.csv"), col_names = TRUE)

### Clean data ###
data_2011 <- clean_names(data_2011)

data_2011 <- data_2011 %>%
  select(survey_year_from,
         a1_4_type_of_library_service_english,
         library_full_name, 
         a1_12_postal_code, 
         a1_14_no_of_active_library_cardholders, 
         b2_6_self_generated_revenue_e_g_fines_fees_sales_fundraising_room_rentals_cafe_revenue_etc,
         b2_9_total_operating_revenues,
         b3_5_total_capital_revenues,
         b4_01_materials, # budget spent on materials
         b4_02_staffing_total_funds_spent_on_all_staff_including_benefits,
         b5_0_total_operating_expenditures,
         c1_2_t_total_volumes_held, # no c0_2_t_total_print_volumes_held
         c2_3_3_t_total_no_of_titles_of_e_resources_including_e_books, # no c0_3_4_t_total_e_book_and_e_audio_copies,
         # no c4_3_03_hoopla,
         # no c5_1_if_you_provide_e_learning_services_e_g_lynda_com_gale_courses_learning_express_please_state_how_many,
         # no c5_2_how_many_cardholders_took_e_learning_courses,
         e1_1_1_provide_internet_access,
         f1_0_total_annual_circulation_actual_annual_direct_circulation,
         f2_2_a_annual_program_attendance,
         f2_311_programs_technology_social_media_and_computer_literacy, #how many programs
         f3_1_2_no_of_items_being_borrowed, # this is how much they borrow from other libraries
         f3_2_2_no_of_items_lent, # how many items they lent to other libraries,
         g1_3_3_w_no_of_people_using_public_library_wireless_connection,
         g1_5_1_w_no_of_visits_to_the_library_made_in_person,
         g1_5_2_w_no_of_electronic_visits_to_the_library_website,
         p1_1_resident_population_served,
         p2_2_resident_households_served
  )

data_2011 <- data_2011 %>%
  rename(year = survey_year_from,
         type = a1_4_type_of_library_service_english,
         name = library_full_name, 
         postal_code = a1_12_postal_code, 
         num_cardholders = a1_14_no_of_active_library_cardholders, 
         revenue_self_generated = b2_6_self_generated_revenue_e_g_fines_fees_sales_fundraising_room_rentals_cafe_revenue_etc,
         revenue_total_operating = b2_9_total_operating_revenues,
         revenue_total_capital = b3_5_total_capital_revenues,
         expend_materials = b4_01_materials, # budget spent on materials
         expend_staff = b4_02_staffing_total_funds_spent_on_all_staff_including_benefits,
         expend_total_operating = b5_0_total_operating_expenditures,
         num_print_volumes = c1_2_t_total_volumes_held,
         num_e_book_audio_titles = c2_3_3_t_total_no_of_titles_of_e_resources_including_e_books,
         # hoopla = c4_3_03_hoopla,
         # num_e_learning_services = c5_1_if_you_provide_e_learning_services_e_g_lynda_com_gale_courses_learning_express_please_state_how_many,
         # num_took_e_learning_courses = c5_2_how_many_cardholders_took_e_learning_courses,
         num_workstations_internet = e1_1_1_provide_internet_access,
         total_direct_circulation = f1_0_total_annual_circulation_actual_annual_direct_circulation,
         program_attendance = f2_2_a_annual_program_attendance,
         num_tech_programs = f2_311_programs_technology_social_media_and_computer_literacy, #how many programs
         ill_num_borrowed = f3_1_2_no_of_items_being_borrowed, # this is how much they borrow from other libraries
         ill_num_lent = f3_2_2_no_of_items_lent, # how many items they lent to other libraries,
         num_use_wifi = g1_3_3_w_no_of_people_using_public_library_wireless_connection,
         num_visits_irl = g1_5_1_w_no_of_visits_to_the_library_made_in_person,
         num_visits_websites = g1_5_2_w_no_of_electronic_visits_to_the_library_website,
         population = p1_1_resident_population_served,
         households = p2_2_resident_households_served
  )