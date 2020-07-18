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

# RENAMING COLUMNS
rename(flights, tail_num = tailnum)

select(flights, time_hour, air_time, everything())

## ADDING A NEW VARIABLE
flights_sml <- select(flights, year:day, ends_with('delay'), distance, air_time)
flights_sml

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

# DISPLAY ONLY THE NEW VARIABLES
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,# interger division
          minute = dep_time %% 100) # remainder

# RANKS
y <- c(1,2,NA,3,4,5)
min_rank(y)
min_rank(desc(y))
percent_rank(y)
cume_dist(y)
dense_rank(y)


# GROUP SUMMARIES
summarize(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
by_day
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

# PIPE OPERATORS
by_dest <- group_by(flights, dest)
by_dest
delay <- summarize(by_dest, count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dest != 'HNL')
delay

ggplot(data = delay, mapping = aes(x=dist, y=delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# USING THE PIPE OPERATOR
delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != 'HNL')

## REMOVINS NA VALUES
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay)
  )

delays
windows()

ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
delays

ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

delays %>%
  filter(n > 25) %>%
  ggplot(mapping = aes(x = n, y = delay)) +
    geom_point(alpha = 1/10)


######################################################################
library(Lahman)
#install.packages('Lahman')

batting <-as_tibble(Batting)
batting

batters <- batting %>%
  group_by(playerID) %>%
  summarize(
    ba = sum(H, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )
batters

batters %>%
  filter(ab > 100) %>%
  ggplot(mapping = aes(x = ab, y = ba)) +
    geom_point() +
    geom_smooth()

batters %>%
  arrange(desc(ba))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    first = min(dep_time),
    last = max(dep_time)
  )

## MEASURE OF POSITION
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )
