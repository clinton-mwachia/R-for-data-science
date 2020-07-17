# TRASFORMING DATA WITH DPLYR
library(nycflights13)
library(tidyverse)

flights
str(flights)
View(flights)

# FILTERING THE DATA USING DPLYR
jan1 <- filter(flights, month == 1, day == 1)
dec25 <- filter(flights, month == 12, day == 25) 

# FLIGHTS DEPARTED IN NOVEMBER OR DECEMBER
filter(flights, month == 11 | month == 12)
# shorthand code for above code is below::
nov_dec <- filter(flights, month %in% c(11, 12))

# FLIGHTS THAT WERE NOT DELAYED MORE THAN TWO HOURS
filter(flights, arr_delay <= 120 | dep_delay <= 120)
filter(flights, !(arr_delay > 120 | dep_delay > 120))

# FLIGHT WITH DELAYS MOE THAN TWO HOURS
filter(flights, arr_delay >= 120)

# FLIGHTS FLEW TO IAH OR HOU
filter(flights, dest == 'IAH' | dest == 'HOU')

# ARRANGE THE DATA
arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))

df <- tibble(y = c(1,90,4,67,NA))
df

arrange(df, y)
arrange(df, desc(y))

# MOST DELAYED FLIGHTS
arrange(flights, desc(dep_delay))
arrange(flights, dep_delay)

# SELECTING SPECIFIED COLUMNS
select(flights, c('year','month','day'))
select(flights, year:day)
# SELECT ALL CLUMNS EXCEPTE YEAT TO DAYA
select(flights, -c(year:day))
