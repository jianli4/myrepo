


library(purrr)
library(tidyverse)
library(purrr)


data<- iris %>% group_by(Species) %>% nest()
fun<- function(x){
 x[1]+x[2]
}

fun2<- function(x){
  return(x)
}
data2<- data %>% mutate(calc=map(data,fun)) %>% transmute(Species,res=map(calc,fun2)) %>% unnest()
data2



###examples
n_iris<- iris %>% group_by(Species) %>% nest()
mod_fun<- function(df) lm(Sepal.Length~.,data=df)
m_iris<- n_iris %>% mutate(model=map(data,mod_fun))
b_fun<- function(mod) coefficients(mod)[[1]]
m_iris %>% transmute(Species,beta=map_dbl(model,b_fun))

###nested dataframe 
###which is also called as list column
###can be created by purrr nest() function and dplyr and tibble packages


