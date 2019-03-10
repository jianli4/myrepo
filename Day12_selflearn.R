###today's goal is to learn quasiquatation 
###ultimate goal is to contruct complext call object

f<- function(data,...){
  library(tidyverse)
  args<- enquos(...)
  data %>% group_by(!!args) %>% tally()
}

f(iris,Sepal.Length,Septal.Width)

cement<- function(...){
  args<- ensyms(...)
  paste(purrr::map(args,as_string),collapse=" ")
}
cement(ni,hao,ma)
first_nm<- "Jian"
last_nm<- "Li"
cement(Hello, !!first_nm,!!last_nm)

named_mean<- function(data,var){
  require(dplyr)
  var<- rlang::ensym(var)
  data %>% summarise(!!name:=mean(!!var))
}
name<- "mean"
named_mean(iris,Sepal.Length)


named_mean<- function(data,...){
  require(dplyr)
  vars<- rlang::ensyms(...)
  data %>% summarise(mean(!!!vars))
}
#not working
named_mean(iris,Sepal.Length,Sepal.Width)

f1<- function(x) expr(x)
f1(a+b+c)


###
f2<- function(data,...){
  args<- enexprs(...)
  eval(data %>% args) 
}

f2(iris,group_by(Species) %>% tally())

call_obj<- rlang::call2('<-',sym("x"),2)
eval(call_obj);x

###using call2() to create complex expressions is a bit cluny. you will learn
###another technique in Chapter 19.
call_obj<- rlang::call2("%>%",iris,expr(group_by(Species)))
eval(call_obj)

