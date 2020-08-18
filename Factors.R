library(tidyverse)
library(forcats)

x <- c(month.abb,'me')
x
sort(x)
# creating a factor
# defining the levels
lev <- month.abb
fac1 <- factor(x, levels = lev)
fac1
sort(fac1)

# making factors using readr
fac1 <- readr::parse_factor(x, levels = lev)
fac1
sort(fac1)
# setting the levels according to the data
fac1 <- factor(x, levels = unique(x))
fac1
 #or
fac1 <- x %>%
  factor() %>%
  fct_inorder()

levels(fac1)

## GENERAL SOCIAL SURVEY USING THE GSS_CAT
View(gss_cat)
str(gss_cat)
# dealing with factors
# count factors
gss_cat %>%
  count(race)

levels(gss_cat$race)
# plotting the factors
# forcing ggplot not to drop na values
windows()
ggplot(data = gss_cat, aes(race)) +
  geom_bar()+
  scale_x_discrete(drop=F) # do not drop NA

# modifying the factor order
# average number of hours spent watching tv per day by religion
relig <- gss_cat %>%
  group_by(relig) %>%
  summarize(
    age = mean(age, na.rm = T),
    tvhours = mean(tvhours, na.rm = T),
    n = n()
  )

ggplot(data = relig, aes(tvhours,fct_reorder(relig, tvhours))) +
  geom_point()

# alt
# preferred
relig %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()

# how average varies across the income level
rincome <- gss_cat %>%
  group_by(rincome) %>%
  summarize(
    age = mean(age, na.rm=T),
    tvhours = mean(tvhours, na.rm = T),
    n = n()
  )
rincome
rincome %>%
  mutate(rincome = fct_reorder(rincome,age)) %>%
  ggplot(aes(age,rincome)) +
  geom_point()

# factor re level
rincome %>%
  ggplot(aes(age, fct_relevel(rincome, 'Not applicable'))) +
  geom_point()

# re ordering the y values by associating them with the largest x values
by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  group_by(age, marital) %>%
  count() %>%
  mutate(prop = n/sum(n))

ggplot(data = by_age, aes(age, prop, color=marital)) +
  geom_line(na.rm=T)

ggplot(data = by_age, aes(age, prop, color=fct_reorder2(marital,age,prop))) +
  geom_line(na.rm=T)

# ordering the bar plots in levels
gss_cat %>%
  mutate(marital = marital %>% fct_infreq()%>%fct_rev()) %>%
  ggplot(aes(marital)) +
  geom_bar()
