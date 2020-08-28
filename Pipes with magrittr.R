# pipes are used for a sequence of operations
library(magrittr)

diamonds <- ggplot2::diamonds
View(diamonds)
diamonds2 <- diamonds %>%
  dplyr::mutate(price_per_carat = price / carat)

# object size
# install.packages('pryr', dependencies = T)
# amount of ram occuppied
pryr::object_size(diamonds)
pryr::object_size(diamonds2)
diamonds$carat[1] <- NA
diamonds
pryr::object_size(diamonds)
object.size(diamonds)

windows()
rnorm(100) %>%
  matrix(ncol = 2) %>%
  plot() %>%
  str()

rnorm(100) %>%
  matrix(ncol = 2) %T>%
  plot() %>%
  str()

#mtcars %>%
#  cor(mpg, disp)
mtcars %$%
  cor(disp, mpg)

####################################################
mtcars <- mtcars %>%
  transform(cyl = cyl * 2)
# replaced with
mtcars %<>% transform(cyl = cyl * 2)
###################################################