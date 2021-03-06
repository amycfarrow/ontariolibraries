### Preamble ###
# Purpose: Importing and cleaning library data for the year 2002
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
data_2002 <- readr::read_csv(here::here("inputs/data/ontario_library_stats_2002.csv"), col_names = TRUE)

### Clean data ###
data_2002 <- clean_names(data_2002)

data_2002 <- data_2002 %>%
  select(year, #survey_year_from,
         library_service_type,
         legal_name, #library_full_name, 
         postal_code, #a1_12_postal_code, 
         number_of_active_library_cardholders, #a1_14_no_of_active_library_cardholders, 
         self_generated_revenue, #b2_6_self_generated_revenue_e_g_fines_fees_sales_fundraising_room_rentals_cafe_revenue_etc,
         total_operating_revenues, #b2_9_total_operating_revenues,
         total_capital_revenues, #b3_5_total_capital_revenues,
         general_materials_expenditure, #b4_01_materials, # budget spent on materials
         staffing_expenditure, #b4_02_staffing_total_funds_spent_on_all_staff_including_benefits,
         total_operating_expenditures, #b5_0_total_operating_expenditures,
         volumes_held_circulating_english_language, volumes_held_circulating_french_language, volumes_held_circulating_other_language, # no c1_2_t_total_volumes_held or no c0_2_t_total_print_volumes_held
         # no c2_3_3_t_total_no_of_titles_of_e_resources_including_e_books or c0_3_3_t_total_e_book_and_e_audio_titles,
         # no c4_3_03_hoopla,
         # no c5_1_if_you_provide_e_learning_services_e_g_lynda_com_gale_courses_learning_express_please_state_how_many,
         # no c5_2_how_many_cardholders_took_e_learning_courses,
         workstations_with_internet_access, #e1_1_1_provide_internet_access,
         total_annual_direct_circulation, # f1_0_total_annual_circulation_actual_annual_direct_circulation,
         annual_program_attendance, # f2_2_a_annual_program_attendance,
         # no f2_311_programs_technology_social_media_and_computer_literacy how many programs
         number_of_items_borrowed, #f3_1_2_no_of_items_being_borrowed, # this is how much they borrow from other libraries
         number_of_items_lent, #f3_2_2_no_of_items_lent, # how many items they lent to other libraries,
         no_of_people_using_public_library_wireless_connection, #g1_3_3_w_no_of_people_using_public_library_wireless_connection,
         typical_week_number_of_library_visits_made_in_person, #g1_5_1_w_no_of_visits_to_the_library_made_in_person,
         typical_week_number_of_electronic_library_visits, #g1_5_2_w_no_of_electronic_visits_to_the_library_website,
         population_resident, #p1_1_resident_population_served,
         households_resident, #p2_2_resident_households_served
  )

data_2002 <- data_2002 %>%
  rename(year = year, #survey_year_from,
         type = library_service_type,
         name = legal_name, #library_full_name, 
         postal_code = postal_code, #a1_12_postal_code, 
         num_cardholders = number_of_active_library_cardholders, #a1_14_no_of_active_library_cardholders, 
         revenue_self_generated = self_generated_revenue, #b2_6_self_generated_revenue_e_g_fines_fees_sales_fundraising_room_rentals_cafe_revenue_etc,
         revenue_total_operating = total_operating_revenues, #b2_9_total_operating_revenues,
         revenue_total_capital = total_capital_revenues, #b3_5_total_capital_revenues,
         expend_materials = general_materials_expenditure, #b4_01_materials, # budget spent on materials
         expend_staff = staffing_expenditure, #b4_02_staffing_total_funds_spent_on_all_staff_including_benefits,
         expend_total_operating = total_operating_expenditures, #b5_0_total_operating_expenditures,
         # num_print_volumes = c1_2_t_total_volumes_held,
         # no num_e_book_audio_titles = c2_3_3_t_total_no_of_titles_of_e_resources_including_e_books,
         # hoopla = c4_3_03_hoopla,
         # num_e_learning_services = c5_1_if_you_provide_e_learning_services_e_g_lynda_com_gale_courses_learning_express_please_state_how_many,
         # num_took_e_learning_courses = c5_2_how_many_cardholders_took_e_learning_courses,
         num_workstations_internet = workstations_with_internet_access, #e1_1_1_provide_internet_access,
         total_direct_circulation = total_annual_direct_circulation, #f1_0_total_annual_circulation_actual_annual_direct_circulation,
         program_attendance = annual_program_attendance, #f2_2_a_annual_program_attendance, 
         # no num_tech_programs = f2_311_programs_technology_social_media_and_computer_literacy, #how many programs
         ill_num_borrowed = number_of_items_borrowed, #f3_1_2_no_of_items_being_borrowed, # this is how much they borrow from other libraries
         ill_num_lent = number_of_items_lent, #f3_2_2_no_of_items_lent, # how many items they lent to other libraries,
         num_use_wifi = no_of_people_using_public_library_wireless_connection, #g1_3_3_w_no_of_people_using_public_library_wireless_connection,
         num_visits_irl = typical_week_number_of_library_visits_made_in_person, #g1_5_1_w_no_of_visits_to_the_library_made_in_person,
         num_visits_websites = typical_week_number_of_electronic_library_visits, #g1_5_2_w_no_of_electronic_visits_to_the_library_website,
         population = population_resident, #p1_1_resident_population_served,
         households = households_resident, #p2_2_resident_households_served
  ) %>%
  mutate(num_print_volumes = volumes_held_circulating_english_language + volumes_held_circulating_french_language + volumes_held_circulating_other_language) %>%
  select(-volumes_held_circulating_english_language, -volumes_held_circulating_french_language, -volumes_held_circulating_other_language)