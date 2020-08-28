df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
df
x <- df$a
x
range(x)
min(x)
max(x)

df$a <- (df$a - min(df$a, na.rm = T)) / 
  (max(df$a, na.rm = T) - min(df$a, na.rm = T))
# can be written as
rng1 <- range(x, na.rm = T)
(x - rng1[1]) / (rng1[2] - rng1[1])

# turn into a function
rescale1 <- function(x){
  rng1 <- range(x, na.rm = T, finite=T)
  (x - rng1[1]) / (rng1[2] - rng1[1])
}
rescale1(c(1,2,3,NA,Inf))

df$a <- rescale1(df$a)
df$b <- rescale1(df$b)
df$b <- rescale1(df$c)
df$d <- rescale1(df$d)

# conditional execution
has_name <- function(x){
  nms <- names(x)
  if(is.null(nms)){
    rep(FALSE, length(x))
  } else {
    nms
  }
}
has_name(df)

# having a multiple if else calls for a switch
calculator <- function(x,y,op){
  # op is a string
  switch(op,
         plus = x + y,
         minus = x - y,
         times = x * y,
         divide = x / y,
         stop('Uknown operation'))
}
calculator(3,3,'plus')
