## NOTE::
## MERGE CAN BE USED IN PLACE OF JOINS THOUGH IT IS SLOW
## inner_join(x,y) == merge(x,y)
## left_join(x,y) == merge(x,y, all.x = TRUE)
## right_join(x,y) == merge(x,y, all.y = TRUE)
## full_join(x,y) == merge(x,y, all.x = TRUE, all.y = TRUE)
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
x

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)
y

## INNER JOIN
## IT KEEPS OBS THAT APPEAR IN BOTH TABLES
## OMMITS UNMATCHING ROWS
x %>%
  inner_join(y, by = 'key')

## OUTER JOIN
## KEEPS OBS THAT APPEAR IN ATLEAST ONE OF THE TABLES
## LEFT JOIN KEEPS ALL OBS IN X (x,y)
## RIGHT JOIN KEEPS OBS IN Y
## FULL JOIN KEEPS ALL OBS IN X AND Y


#### DEALING WITH DUPLICATE KEYS
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)
x

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)
y

left_join(x, y, by = "key")

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  3, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  2, "y3",
  3, "y4"
)
left_join(x, y, by = "key")

###################################################################
flights2 %>%
  left_join(weather)

flights %>%
  left_join(planes, by = 'tailnum')

## JOINING WHEN THEIR ARE NO COLUMNS THAT LOOK ALIKE
flights2 %>%
  left_join(airports, by = c("dest" = "faa"))

flights2 %>%
  left_join(airports, by = c("origin" = "faa"))

######################################################################
## FILTERING JOINS
## semi_join(x,y) keeps all obs in x that have a match in y
## anti_join(x, y) drops all obs in x that have a match in y

top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest

flights %>%
  filter(dest %in% top_dest$dest)

flights %>%
  semi_join(top_dest)

flights %>%
  anti_join(planes, by = 'tailnum') %>%
  count(tailnum, sort = TRUE)
