


library(purrr)
library(tidyverse)
library(purrr)


data<- iris %>% group_by(Species) %>% nest()
fun<- function(x){
  x[1]+x[2]
}

data2<- data %>% mutate(model=map(data,fun)) %>% unnest()
data2
