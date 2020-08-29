library(tidyverse)

# FOR LOOPS
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
df

# median
seq_along(df)

vec <- vector('double', ncol(df))
for (i in seq_along(df)) {
  vec[i] <- median(df[[i]])
}
vec
sapply(df, median)

# the map function
map_dbl(df, median)
map_dbl(df, mean)
map_dbl(df, sd)

map_dbl(df, length)

# models
models <- mtcars %>%
  split(.$cyl) %>%
  map(function(df) lm(mpg~wt, data = df))
