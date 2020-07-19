library(tidyverse)
library(nycflights13)

flights

flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2
airlines

# COMBINING AIRLINES AND FLIGHTS2 DATA USING LEFT JOIN
flights2 %>%
  select(-origin, -dest) %>%
  left_join(airlines, by = 'carrier')

# COMBINING AIRLINES AND FLIGHTS2 DATA USING MUTATE
flights2 %>%
  select(-origin, -dest) %>%
  mutate(name = airlines$name[match(carrier, airlines$carrier)])
