library(tibble)
library(dplyr)
library(tidyr)


data("mtcars")
mydf <- rownames_to_column(mtcars, "car") %>% as_tibble()
