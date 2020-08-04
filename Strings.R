library(tidyverse)
# simple string manipulation
library(stringr)
# intensive string manipulation
library(stringi)
library(microbenchmark)

#?'""'
# length of a string including a space
str_length('tonny')
str_length(c('moshe', 'clinton'))

# combing strings
# separate by space
str_c('Clinton', 'Moshe', 'Mwachia', sep = " ")
# separate by comma
str_c('Clinton', 'Moshe', 'Mwachia', sep = ",")
# separate by .
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

str_trim(' moshe ')

## MATCHING PATTERNS WITH REGULAR EXPRESSIONS.
x <- c('apple','banana','pear')
str_view(x, 'an')
str_view(x, '.a.')

x <- c('abc','a.c','bef')
str_view(x, 'a\\.c')

str_view('a\\b', '\\\\')


# start to end
x <- c('apple','banana','pear')
# ^ start with
str_view(x,pattern = '^a')
# $ end with
str_view(x, pattern = 'a$')

str_view(x, pattern = '^apple$')

str_view(fruit, '(...)\\1', match = TRUE)

### DETECT MATCHES
x <- c('apple','banana','pear')
str_detect(x, 'e')

# number of words starting with a
sum(str_detect(x, '^a'))
# number of words ending with a vowel
sum(str_detect(x, '[aeiou]$'))

# detect vowels in x
str_detect(x, '[aeiou]')

words[str_detect(words, 'x$')]
str_subset(words, 'x$')


df <- tibble(
  word = words,
  i = seq_along(word)
)
df %>%
  filter(str_detect(words, 'x$'))

# count occurrences
str_count(x, 'p')
str_count(x, '[aeiou]')


df %>%
  mutate(
    vowels = str_count(words, '[aeiou]'),
    consonants = str_count(words, '[^aeiou]')
  )

str_count('moshettmoshe', 'moshe')
str_view_all('moshettmoshe', 'moshe')


# EXTRACT MATCHES
sentences
## find sentences that have a color name
colors <- c(
  'red','orange','yellow','green','blue','purple'
)
colors
# defining the or
color_match <- str_c(colors, collapse = '|')
color_match

has_color <- str_subset(sentences, color_match)
has_color
# extracts the first match
matches <- str_extract(has_color, color_match)
matches

more <- sentences[str_subset(sentences, color_match) > 1]
str_view_all(more, color_match)
str_extract_all(more, color_match, simplify = TRUE)

x <- c('a','a b','a b c')
str_extract_all(x, '[a-z]', simplify = T)

# GROUP MATCHES
# extract nouns
noun <- '(a|the) ([^ ]+)'
has_noun <- sentences %>%
  str_subset(noun) %>%
  head(10)
has_noun
has_noun %>%
  str_extract(noun)

has_noun %>%
  str_match(noun)

tibble(sentence = sentences) %>%
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)",
    remove = FALSE
  )

# REPLACE MATCHES
x <- c('apple','banana','pear')
str_replace(x, '[aeiou]', '-')
str_replace_all(x, '[aeiou]', '-')
x <- c('1 apple','10 banana','3 pear')
str_replace_all(x, c('1'='one','10'='ten','3'='three'))

# SPLITTING
# split words
sentences %>%
  head(5) %>%
  str_split(' ', simplify = TRUE)

fields = c('Name: Clinton', 'Country: Kenya', 'Age: 24')
fields %>%
  str_split(':', n = 2, simplify = TRUE)

# split by character, line_break, sentence and word
x <- 'This is a sentence. This is another sentence.'
str_view_all(x, boundary('sentence'))

str_split(x, boundary('sentence'))

# FIND MATCHES
str_view(fruit, 'nana')
str_view(fruit, regex('nana'))

banana <- c('banana','Banana','BANANA')
str_view(banana, regex('banana', ignore_case = TRUE))

x <- 'line1\nline2\nline3'
x
str_extract_all(x, regex('^line',multiline = TRUE))[[1]]

x <- '
# comment 1
# comment2
clinton
'
x
str_extract_all(x, regex('clinton'))[[1]]
# fixed is faster
str_detect(x, fixed('clinton'))

# testing speed
# fixed is faster than regex
microbenchmark(
  fixed = str_detect(sentences, fixed('the')),
  regex = str_detect(sentences, 'the'),
  times = 20
)

# NOTE::
a1 = "\u00e1"
a2 = "a\u0301"
c(a1, a2)
a1 == a2

str_detect(a1, fixed(a2))
# coll compares bytes
str_detect(a1, coll(a2))


i <- c('I','I','i','i')
i
str_subset(i, coll('i', ignore_case = TRUE))

str_subset(i, coll('i', ignore_case = TRUE, locale = 'tr'))
# locales
stringi::stri_locale_info()

# testing time for both the 3
microbenchmark(
  fixed = str_detect(sentences, fixed('the')),
  regex = str_detect(sentences, 'the'),
  colll = str_detect(sentences, coll('the')),
  times = 20
)

# find objects in the local environment
searchpaths()
search()
# search for functions
apropos('geom')

# search for files in the current dir
dir(pattern = '*.R$')


stringi::stri_count('moshe moshe', fixed = 'moshe')
