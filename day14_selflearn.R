

###evaluation
library(rlang)
eval(expr(x+y),env(x=1000,y=100))

parent.frame()

###use local() function to eliminate intermediate 
###variables
foo<- local({
  x<- 10
  y<- 200
  x+y
})
foo
x
y

local2<- function(expr){
  env<- env(caller_env())
  eval_bare(enexpr(expr),env)
}
foo<- local2({
  x<- 10
  y<- 200
  x+y
})

###mimic base R source() function
source2<- function(path,env=caller_env()){
  file<- paste(readLines(path,warn=FALSE),collapse="\n")
  exprs<- parse_exprs(file)
  
  res<- NULL
  for(i in seq_along(exprs)){
    res<- eval(exprs[[i]],env)
  }
  invisible(res)
}
source2("day3_Rcode.R")


map_by<- function(data,by,...){
  by_a<- paste0(by,collapse = ",")
  by_g<- str_replace(str_replace(by_a,"desc\\(",""),"\\)","")
  text<- paste0("data %>% arrange(",by_a,")"," %>% group_by(",by_g,") %>% nest() %>% mutate(model=map(data,...)) %>% select(-data) %>% unnest(model) %>% as.data.frame()")
  expr<- parse_expr(text)
  eval(expr)
}
map_by(iris,by=c("Species","Sepal.Length"),nrow)
map_by(iris,by=c("Species"),nrow)
map_by(iris,by=c("Species","desc(Sepal.Length)"),nrow)
