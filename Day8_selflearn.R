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




library(ggplot2)
library(gganimate)

devtools::install_github("https://github.com/rstudio/gt.git")

