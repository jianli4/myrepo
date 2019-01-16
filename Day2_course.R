


##pull from the past 
#git b
#git checkout -b the-past 7829d9053333a85f9edbacb3132efd6eefd8181f



###purrr package intro!!!!
library(purrr)
library(repurrrsive)
library(tidyverse)

str(got_chars)
class(got_chars)
length(got_chars)
str(got_chars[[9]],list.len=4) ###keep to the first 4
View(got_chars)

got_chars[[1]]$name
got_chars[[9]]$name
str(got_chars[[9]]);names(got_chars[[9]])

class(got_chars[9])
class(got_chars[[9]])


###map(.x,.f,...)
###for every element of .x do .f
out<- vector(mode="list",length=length(.x))
#do it for one element
#find the general receipe
#drop into map() to do for all

res<- map(got_chars,function(x) data.frame(names=x[["name"]],num=length(x[["aliases"]])))
final_res<- do.call('rbind',res)
final_res

res2<- map(got_chars,~data.frame(name=.x[["name"]],num_titles=length(.x[["titles"]])))
do.call('rbind',res2)

###map friends
map_int(got_chars,~length(.x[["aliases"]]))
map_lgl(got_chars,~.x[["alive"]])
map_chr(got_chars,~.x[['name']])
map_chr(got_chars,'name') ###shortcut, .f accepts a name or position

#exercise
map_chr(got_chars,'gender')
map_chr(got_chars,'born')
#not working:
#map_chr(got_chars,~data.frame(.x[['gender']],.x[['name']]))

map_chr(got_chars,~length(.x[["playedBy"]]))

map(got_chars,4)
map(got_chars,3)#third element from each list
map_chr(got_chars,list("playedBy",1)) ##choose the first one
map_chr(got_chars,~.x[["playedBy"]][1])
map(sw_vehicles,'pilots')

###.default parameter is good for Missing values
map(sw_vehicles,list('pilots',1),.default=NA)

#set names
#this extra step really pay off 
got_chars_named<- set_names(got_chars,map_chr(got_chars,"name"))
map_lgl(got_chars_named,"alive") %>% tibble::enframe() ###tibble enframe()
map_chr(got_chars_named,"born")

#map2
#map2(minis,hair,enhair)
#pmap:multiple mapping
?map2

x <- list(1, 10, 100)
y <- list(1, 2, 3)
z <- list(5, 50, 500)

map2(x, y, ~ .x + .y)
pmap(list(x,y,z),sum)
