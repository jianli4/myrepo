
f<- function(data=mtcars,vars=expr(mpg+cyl)){
  eval_tidy(vars,data=data)
}
f(vars=expr(mpg-cyl))




a<- 1;b<- 2
p<- quo(.data$a+!!b)
mask<- tibble(a=5,b=6)
eval_tidy(p,data=mask)

name<- "Jane"
list2(!!name:=1+2)
list2(name:=1+2)
list2("Jane":=1+2)

exprs(!!name:=1+2)
quos(!!name:=1+2)



args<- list(1:3,na.rm=TRUE)
(length(!!!args))

x<- list(8,b=2)
expr(log(!!!x))
expr(log(!!x))
eval(expr(log(!!!x)))



add1<- function(x){
  q<- rlang::enquo(x)
  rlang::eval_tidy(q)+1
}
add2<- function(x){
  x+1
}
a<- 2
add1(!!a)
add1(a)
add2(a)
add2(!!a) ##TRUE+1

##program with a uoting function
data_mean<- function(data,var){
  require(dplyr)
  var<- rlang::enquo(var)
  data %>% summarise(mean=mean(!!var))
}
data_mean(mtcars,c("mpg","cyl"))


###by process is achived in ...
group_mean<- function(data,var,...){
  require(dplyr)
  var<- rlang::enquo(var)
  group_vars<- enquos(...)
  data %>% group_by(!!!group_vars) %>% summarise(mean=mean(!!var))
}
group_mean(data=mtcars,var=mpg,cyl,gear)

#modify user arguments
my_do<- function(f,v,df){
  f<- rlang::enquo(f)
  v<- rlang::enquo(v)
  todo<- rlang::quo((!!f)(!!v))
  rlang::eval_tidy(todo,df)
}
my_do(mpg,cyl,mtcars)

subset2<- function(df,rows){
  rows<- rlang::enquo(rows)
  vals<- rlang::eval_tidy(rows,data=df)
  df[vals,,drop=FALSE]
}
subset2(mtcars,list(cyl=1))
subset



#'@importFrom rlang.data
mutate_y<- function(df){
  dplyr::mutate(df,y=.data$a+1)
}
mutate_y(mtcars)





library(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')
