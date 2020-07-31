library(tidyverse)
library(stringr)

x <- c('clinton','moshe','editah')
str_view(x, pattern = 'cli')
str_view(x, pattern = '.c.')

str_view(c('abc','a.c','bef'), 'a\\.c')
str_view('a\\b', pattern = '\\\\')
# ^ marks the start of a string
# $ marks the end of the string
# \d any digit
# \s whitespace
# [a,b,c] matches a,b, or c
# [^abc] matches anything except a,b,or c
str_view(x, '^e')
str_view(x, 'e$')

x <- c('apple pie', 'apple', 'apple cake')
str_view(x, 'apple')
str_view(x, '^apple$')

str_view(words, '^y')
str_view(words, 'x$')

x <- 'moshe399'
str_view(x, pattern = '\\d')

x <- c('clinton','clenton','moshe')
str_view(x, pattern = 'cl(i|e)n')


x <- '1888 is the longest year in roman numerasl: MGCCCLXXXVIII'
str_view(x, pattern = 'CC?')
str_view(x, pattern = 'CC+')
