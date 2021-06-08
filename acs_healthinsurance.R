library(dplyr)
library(tidyverse)
library(xlsx)

acs <- read_csv("/Users/stephaniepeng/Desktop/BIMI_Carl_Jupyter/ACSDT5Y2019.B27020_2021-05-27T131538/ACSDT5Y2019.B27020_data_with_overlays_2021-05-27T131426.csv")

acs_clean <- acs %>% 
  separate('Geographic Area Name', c("Place", "State"), sep=",") %>%
  filter(State == " California" | State == " Arizona") %>%
  filter(str_detect(Place, "CDP") == FALSE) %>%
  mutate(City_Clean = str_remove(Place, "city"),
         City_Clean = str_remove(City_Clean, "City"),
         City_Clean = str_remove(City_Clean, "town"),
         City_Clean = tolower(City_Clean),
         City_Clean = str_trim(City_Clean)) %>%
  select(Place, State, City_Clean,
         "Total Population" = `Estimate!!Total:`,
         "Native Born Population" = `Estimate!!Total:!!Native Born:`,
         "Foreign-Born Population" = `Estimate!!Total:!!Foreign Born:`,
         "Native Born Uninsured" = `Estimate!!Total:!!Native Born:!!No health insurance coverage`,
         "Foreign-Born Uninsured" = `Estimate!!Total:!!Foreign Born:!!Noncitizen:!!No health insurance coverage`)

wri
write.xlsx(acs_clean, "/Users/stephaniepeng/Desktop/BIMI_Carl_Jupyter/acs_clean.xlsx")
