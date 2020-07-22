library(tidyverse)
library(stringr)

#?'""'
# length of a string including a space
str_length('tonny')
str_length(c('moshe', 'clinton'))

# combing strings
# seperate by space
str_c('Clinton', 'Moshe', 'Mwachia', sep = " ")
# seperate by comma
str_c('Clinton', 'Moshe', 'Mwachia', sep = ",")
# seperate by .
str_c('Clinton', 'Moshe', 'Mwachia', sep = ".")

str_c('prefix-', c('a','b','c'), '-suffix')

# replace the na
x <- c('moshe', NA)
str_replace_na(x, '999')

# subsetting strings
x <- 'clinton'
str_sub(x, start = 1, end = 5)
str_sub(x, start = -2, end = -1)

x <- c('moshe','clinton')
str_sub(x, start = 1, end = 5)
str_sub(x, start = -2, end = -1)

x <- 'CLINTON'
str_to_lower(x)
str_to_title(x)

x <- 'clinton'
str_to_upper(x)


x <- c('d','z','b','a')
str_sort(x)

x <- c('moshe','james', 'apple')
str_sort(x, locale = 'en')
str_order(x)
