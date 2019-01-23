###gganimate package
###gt package

###dplyr::tally() function 
installed.packages() %>% as_tibble() %>% group_by(Built) %>% tally()
#count() is a short-hand for group_by()+tally() functions
installed.packages() %>% as_tibble() %>% count(Built)
#add_tally() is a short-hand for mutate()
mtcars %>% add_tally()
#add_count() is a short-hand for group_by() + add_tally() functions
mtcars %>% add_count(cyl)
#just to confirm the results is right
mtcars %>% group_by(cyl) %>% tally()

##count() and tally() are designed so that you can call them repeatedly, each time rolling up a level of detail
species<- starwars %>% count(species,homeworld,sort=TRUE)
species
species %>% count(species,sort=TRUE) #recount

##change the name of the newly created column:
##it seems that newest version of dplyr doesn't have this feature
species<- starwars %>% count(species,homeworld,sort=TRUE,name="n_species_by_homeworld")
species

###add_count() function is useful for groupwise filtering
#e.g.: show details for species that have a single member
starwars %>% add_count(species) 
###Besides calculating the count,add_count() will output all of the variables along with n


###function to handle by-processing in work
###it's better to move select(-data) ahead of unnest(model)
map_by<- function(data,by,...){
  data %>% arrange_(.dots=by) %>% group_by_(.dots=by) %>% nest() %>% mutate(
    model=map(data,...)) %>% select(-data) %>% unnest(model) %>% as.data.frame(.)
}
map_by(mtcars,"cyl",function(x) dim(x)[2])

library(ggplot2)
library(gganimate)

library(devtools)
remotes::install_github("rstudio/gt")
library(gt)

example("gt")
tab_1<- exibble %>% gt(rowname_col="row",groupname_col="group")
head(exibble)

tab_2<- pizzaplace %>% top_n(100) %>% gt() %>% as_rtf()
writeLines(tab_2,"~/Desktop/pizzaplace.rtf")
# write_file(tab_2,"pizzaplace.docx")
tab_2
as_rtf(tab_2)
