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

# from other types
# switching between datetime and date
as_datetime(today())
as_date(now())

# date time components
# getting components
# mday: day of the month
# yday: day of the year
# wday: day of the week
datetime <- ymd_hms('20160708 12:34:56')
datetime
year(datetime)
month(datetime)
mday(datetime)
yday(datetime)
wday(datetime)

View(flights_dt)
windows()
flights_dt %>%
  mutate(wday = wday(dep_time, label = T)) %>%
  ggplot(aes(x=wday)) +
  geom_bar()

flights_dt %>%
  mutate(minute = minute(dep_time)) %>%
  group_by(minute) %>%
  summarize(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>%
  ggplot(aes(minute, avg_delay)) +
  geom_line()

sched_dep <- flights_dt %>%
  mutate(minute = minute(sched_dep_time)) %>%
  group_by(minute) %>%
  summarize(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n())
ggplot(sched_dep, aes(minute, avg_delay)) +
  geom_line()

ggplot(sched_dep, aes(minute, n)) +
  geom_line()

# Rounding off the data to a nearby unit of time
flights_dt %>%
  count(week = floor_date(dep_time,'week')) %>%
  ggplot(aes(week,n))+
  geom_line()

# setting components
datetime
year(datetime) <- 2020
month(datetime) <- month(Sys.time())
hour(datetime)

update(datetime, year=2020, month=10, mday=16)

ymd(20161016) %>%
  update(mday=16, month=10, year=2020)

flights_dt %>%
  mutate(dep_hour = update(dep_time, yday = 1)) %>%
  ggplot(aes(dep_hour)) +
  geom_freqpoly(binwidth = 300)

# Time spans
# time difference
# Duration
my_age <- today() - ymd(19951016)
my_age
as.duration(my_age)

dseconds(15)
dminutes(15)
dhours(24)
ddays(5)
dweeks(3)
dyears(1)


one_pm <- ymd_hms(
  '20200826 13:00:00',
  tz = Sys.timezone()
)
one_pm
one_pm + ddays(1)
one_pm + dhours(24)
Sys.time() + dhours(24)

# Periods
seconds(10)
minutes(20)
hours(4)
days(7)
months(2)
weeks(2)
years(2)

# arithmetic
hours(1) + minutes(20) + seconds(40)

Sys.time() + ddays(1)
Sys.time() + days(1)

flights_dt %>%
  filter(arr_time < dep_time)

flights_dt <- flights_dt %>%
  mutate(
    overnight = arr_time < dep_time,
    arr_time = arr_time + days(overnight * 1),
    sched_arr_time = sched_arr_time + days(overnight * 1)
  )

flights_dt %>%
  filter(overnight, arr_time < dep_time)


# intervals
years(1) / days(1)

next_year <- today() + years(1)
next_year
(today() %--% next_year) %/% ddays(1)
(today() %--% next_year) / dyears(1)

# TIME ZONES
# complete list of time zones
length(OlsonNames())
head(OlsonNames(),20)
ymd(20201016, tz='Africa/Nairobi')

newtz <- with_tz(
  ymd(20201016, tz='Africa/Nairobi'),
  tzone = 'Australia/Lord_Howe'
)
newtz

newtz <- force_tz(
  ymd(20201016, tz='Africa/Nairobi'),
  tzone = 'Australia/Lord_Howe'
)
newtz
