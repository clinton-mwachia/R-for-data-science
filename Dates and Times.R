library(tidyverse)
library(lubridate)
library(nycflights13)

# creating dates and times
# current date and time
today()
now()

# creating date and times from strings
ymd("2020-08-21")
mdy("february 21st, 2020")
mdy("08-21-2020")
dmy("21-08-2020")
dmy("21st january 2020")


ymd(20200821)

# date times
ymd_hms("20200821 20:11:58")
mdy_hm("08212020 03:23")

ymd(20200821, tz=Sys.timezone())

# dealing with individual components
View(flights)

flights %>%
  select(year, month, day, hour, minute)

# making dates and date times
flights %>%
  select(year, month, day, hour, minute) %>%
  mutate(
    departure = make_datetime(year,month,day,hour,minute)
  )

# formatting the times of the departure times
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time%%100)
}

flights_dt <- flights %>%
  filter(!is.na(dep_time), !is.na(arr_time)) %>%
  mutate(
    dep_time = make_datetime_100(year, month,day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year,month,day,sched_dep_time),
    sched_arr_time = make_datetime_100(year, month,day,sched_arr_time)
  ) %>%
  select(origin, dest, ends_with('time'), ends_with('delay'))
  
# visualize departure time
# 1 means 1 second
# 86400 means 86400 seconds , 1 day
flights_dt %>%
  ggplot(aes(dep_time)) +
  geom_freqpoly(binwidth=86400)

flights_dt %>%
  filter(dep_time < ymd(20130102)) %>%
  ggplot(aes(dep_time)) +
  geom_freqpoly(binwidth=600)
