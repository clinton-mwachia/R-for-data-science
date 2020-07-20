library(tidyr)

df1 <- tribble(
  ~x, ~y,
  1, 1,
  2, 1
)
df1
df2 <- tribble(
  ~x, ~y,
  1, 1,
  1, 2
)
df2

intersect(df1, df2)
union(df1, df2)
setdiff(df2, df1)
