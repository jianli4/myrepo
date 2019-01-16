.Library ###search for the default path for libraries
.libPaths()


use_course("rstd.io/wtf-explore-libraries")

installed.packages() %>% as_tibble() %>% count(Built) 
list.files(.Library)


###library: fs
###for directory and file system handling 
dir_info()
dir_ls()
fs::path_home()
good<- fs::path_home("tmp/test.csv") ###get the directory for that newly created file
good
dir_create("figs") ###create a new folder figs under current wd
dir_ls(glob = "*.R") ###search for all R programs

###library:here
library(here)
here::here("*.md")
system("tree")
###here() function is not for creating directories
ggsave(here("figs", "built-barchart.png")) ###perfect for creating the location

dir_ls(here("figs"))


if(dir_exists(here("figs"))){
  dir_create(here("figs"))
}
dir_delete(here("new")) ###One-time shot

####file names 

ft<- tibble(files=dir_ls(glob = "*.R")) ####search for all R programs under current WD
ft %>% filter(str_detect(files,"course")) ###filter out the programs that contains the course word
ft %>% mutate(files=path_ext_remove(files)) %>% separate(files,into=c("Day","Topic"),sep="_")
###take-away: separate() function
###path_ext_remove() function to remove extension



###usethis
library(usethis)
use_course("rstd.io/wtf-packages-report")


###debugging 

f<- function(x){
  browser()
  str(x)
  x+1
}
f("a")




###YAML languages 
###output to github_document for rendering md files instead of Rmd and html files


