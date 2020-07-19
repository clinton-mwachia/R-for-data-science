library(tidyverse)
library(nycflights13)

airlines
airports
planes
weather

# VERFYING THE PRIMARY KEYS
# PRIMARY KEY IS UNIQUE TO EVERY OBSERVATION
planes %>%
  count(tailnum) %>%
  filter(n > 1)

weather %>%
  count(year, month, day, hour, origin) %>%
  filter(n > 1)

flights %>%
  count(year, month, day, flight) %>%
  filter(n > 1)

