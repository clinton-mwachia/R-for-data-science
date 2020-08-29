library(tidyverse)
# atomic vectors: logical, integer, double, character, complex, raw
# they are homogeneous
# lists: recursive vectors.
# heterogeneous

# vector props
# type
typeof(letters)
typeof(1:10)

# length
length(letters)

# NAMING VECTORS
c(x=1,y=2,z=4)
set_names(1:3, c('a','b','c'))
